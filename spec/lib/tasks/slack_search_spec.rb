require "rake_helper"

describe "slack_search" do # rubocop:disable RSpec/DescribeClass
  let(:task1) { Rake.application["slack_search:search_users"] }
  let(:task2) { Rake.application["slack_search:join_community"] }

  let(:users_list_mock) {
    { members: [{ profile: { email: "sample1@example.com", real_name: "sample1" } },
                { profile: { email: "sample2@example.com", real_name: "sample2" } },
                { profile: { email: "sample@example.com", real_name: "t-ehara" } }] }
  }

  before {
    client_mock = instance_double("Slack Client")
    allow(client_mock).to receive(:token=)
    allow(client_mock).to receive(:users_list).and_return(users_list_mock)
    allow(Slack::Web::Client).to receive(:new).and_return(client_mock)
  }

  context "コミュニティと slack が連携している時" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:user) { create(:user, name: "t-ehara", email: "sample@example.com") }
    let(:community) { create(:community, owner: user, slack_access_token: "SLACK-ACCESS-TOKEN") }
    let!(:community_user) { create(:community_user, user: user, community: community) }
    it "バッチ処理が実行される" do
      expect { task1.execute }.to change { User.count }.from(1).to(3)
      expect(task1.execute).to be_truthy
      expect { task2.execute }.to change { community.users.count }.from(1).to(3)
      expect(task2.execute).to be_truthy
    end
  end

  context "コミュニティがslack 連携をしていない時" do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:user) { create(:user, name: "t-ehara", email: "sample@example.com") }
    let(:community) { create(:community, owner: user, slack_access_token: nil) }
    let!(:community_user) { create(:community_user, user: user, community: community) }
    it "バッチ処理はスキップされる" do
      expect { task1.execute }.not_to change { User.count }
      expect(task1.execute).to be_truthy
      expect { task2.execute }.not_to change { community.users.count }
      expect(task2.execute).to be_truthy
    end
  end
end
