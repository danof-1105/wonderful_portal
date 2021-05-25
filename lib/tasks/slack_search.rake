namespace :slack_search do
  desc "search_users"
  task search_users: :environment do
    client = Slack::Web::Client.new
    all_members_data = client.users_list[:members]
    all_members_email = all_members_data.map {|member_data| member_data[:profile][:email] }
    all_members_email = all_members_email.compact # rubocop:disable Lint/UselessAssignment
  end
end
