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
    client = Slack::Web::Client.new
    community = Community.first
    target_users_email = community.users.pluck(:email)
    all_members_data = client.users_list[:members]
    all_members_data.each do |member_data|
      next if member_data[:profile][:email].nil?

      unless target_users_email.include?(member_data[:profile][:email])
        community.users << User.find_by(email: member_data[:profile][:email])
      end
    end
  end
end
