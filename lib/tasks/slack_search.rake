namespace :slack_search do
  desc "search_users"
  task search_users: :environment do
    client = Slack::Web::Client.new
    user_emails = User.pluck(:email)
    all_members_data = client.users_list[:members]
    all_members_data.each do |member_data|
      next if member_data[:profile][:email].nil?

      unless user_emails.include?(member_data[:profile][:email])
        User.create!(name: member_data[:profile][:real_name], email: member_data[:profile][:email])
      end
    end
  end

  ## 現状の課題
  # - コミュニティが1つのみに限定されている
  #   - Slack のデータの取得はどうやっている？（コミュニティごとに取得する方法は？）
  #   - slack_ruby_client に設定されているトークン（アプリで1つしか設定できない）を利用している模様
  #   - Slack 連携を有効にしているコミュニティごとに、Slack からデータを取得できるようにしたい

  desc "slack に登録しているユーザーについてコミュニティに自動で参加する機能"
  task join_community: :environment do
    client = Slack::Web::Client.new

    # community に対象の slack のトークン情報が保持されている
    # community に slack 連携の ON/OFF 情報もあったほうがよさそう => slack_cooperation
    communities = Community.where(slack_cooperation: true)

    communities.each do |community|
      next unless community.slack_access_token.present?

      client.token = community.slack_access_token

      joined_user_emails = community.users.pluck(:email)
      # joined_user_emails = ["foo@example.com", "bar@example.com"]

      all_members_data = client.users_list[:members]
      all_members_emails = all_members_data.map {|member_data| member_data[:profile][:email] }.compact
      # all_members_emails = ["foo@example.com", "hoge@example.com"]

      # 追加したいユーザーのメールアドレス
      add_user_emails = all_members_emails - joined_user_emails

      # 削除したいユーザーのメールアドレス
      delete_user_emails = joined_user_emails - all_members_emails

      existed_users = community.users.where(email: add_user_emails)
      add_user_emails.each do |email|
        # もしユーザーがいれば、コミュニティに追加する
        # もしユーザーがいなければ、ユーザーを新規作成した上で、コミュニティに追加する
        user = existed_users.find {|user| user.email == email } || User.create!(email: email)
        # user = User.find_or_create_by!(email: email)
        # user = User.find_by(email: email) || User.new(email: email)
        community.users << user
        # community.community_users.create!(user: user)
        # resource.save!
        # resource.create!
        # resource.update!(params)
      end

      delete_user_emails.each do |email|
        target_user = User.find_by(email: email)
        community_user = target_user.community_users.find_by(community: community)
        community_user.destroy!
      end
    end
  end
end
