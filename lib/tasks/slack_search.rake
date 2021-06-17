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

  desc "slack に登録しているユーザーについてコミュニティに自動で参加する機能"
  task join_community: :environment do
    ActiveRecord::Base.transaction do
      client = Slack::Web::Client.new
      communities = Community.where(slack_cooperation: true)
      communities.each do |community|
        next if community.slack_access_token.blank?

        client.token = community.slack_access_token
        joined_user_emails = community.users.pluck(:email)
        all_members_data = client.users_list[:members]
        all_members_emails = all_members_data.map {|member_data| member_data[:profile][:email] }.compact
        add_user_emails = all_members_emails - joined_user_emails
        delete_user_emails = joined_user_emails - all_members_emails
        existed_users = community.users.where(email: add_user_emails)
        add_user_emails.each do |email|
          user = existed_users.find {|existed_user| existed_user.email == email }
          community.community_users.create!(user: user)
        end
        delete_user_emails.each do |email|
          target_user = User.find_by(email: email)
          community_user = target_user.community_users.find_by(community: community)
          community_user.destroy!
        end
      end
    end
  end
end
