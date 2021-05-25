namespace :slack_search do
  desc "search_users"
  task search_users: :environment do
    client = Slack::Web::Client.new
    all_members_data = client.users_list[:members]
    all_members_email = all_members_data.map do |member_data| # rubocop:disable Lint/UselessAssignment
      member_data[:profile][:email]
    end.compact # rubocop:disable Style/MethodCalledOnDoEndBlock
  end
end
