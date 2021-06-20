require "rake_helper"

describe "slack_search" do # rubocop:disable RSpec/DescribeClass
  let(:task1) { Rake.application["slack_search:search_users"] }
  let(:task2) { Rake.application["slack_search:join_community"] }

  it "slack 連携のバッチ処理が実行される" do
    expect(task1.invoke).to be_truthy
    expect(task2.invoke).to be_truthy
  end
end
