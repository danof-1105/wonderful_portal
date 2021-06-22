require "rake_helper"

describe "slack_search" do # rubocop:disable RSpec/DescribeClass
  let(:task1) { Rake.application["slack_search:search_users"] }
  let(:task2) { Rake.application["slack_search:join_community"] }

  let(:users_list_mock) { { members: [ { profile: { email: "sample1@example.com", real_name: "sample1" } },
                                       { profile: { email: "sample2@example.com", real_name: "sample2" } },
                                       { profile: { email: "sample@example.com", real_name: "t-ehara" } }
  ] } }

  before { allow_any_instance_of(Slack::Web::Client).to receive(:users_list).and_return(users_list_mock) }

  context "コミュニティと slack が連携している時" do
    let(:user) { create(:user, name: "t-ehara", email: "sample@example.com") }
    let!(:community) { create(:community, owner: user, slack_access_token: "xoxp-abcdefghijklmn123456789")}
    it "バッチ処理が実行される" do
      user.have_communities.first.community_users.create!(user: user)
      expect{ task1.execute }.to change{ User.count }.from(1).to(3)
      expect(task1.execute).to be_truthy
      expect{ task2.execute }.to change{ community.users.count }.from(1).to(3)
      expect(task2.execute).to be_truthy
    end
  end

  context "コミュニティがslack 連携をしていない時" do
    let(:user) { create(:user, name: "t-ehara", email: "sample@example.com") }
    let!(:community) { create(:community, owner: user, slack_access_token: nil) }
    it "バッチ処理はスキップされる" do
      user.have_communities.first.community_users.create!(user: user)
      expect{ task1.execute }.not_to change{ User.count }
      expect(task1.execute).to be_truthy
      expect{ task2.execute }.not_to change{ community.users.count }
      expect(task2.execute).to be_truthy
    end
  end
end
