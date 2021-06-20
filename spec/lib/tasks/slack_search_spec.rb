# require 'rake_helper'


# describe 'slack_search' do
#   subject(:task) { Rake.application['slack_search'] }

#   it 'slack 連携のバッチ処理が実行される' do
#     binding.pry
#     expect { task.invoke }.to be_truthy
#   end
# end
require 'rails_helper'
require 'rake'

describe 'rake task slack_search' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/slack_search' # Point 1
    Rake::Task.define_task(:environment)
  end

  before(:each) do
    @rake[task].reenable  # Point 2
  end

  describe 'slack_search:search_users' do
    let(:task) { 'slack_search:search_users' }
    it 'slack と連携したユーザー登録' do
      expect(@rake[task].invoke).to be_truthy
    end
  end
  describe 'slack_search:join_community' do
    let(:task) { 'slack_search:join_community' }
    it 'slack と連携したコミュニティ参加機能' do
      expect(@rake[task].invoke).to be_truthy
    end
  end
end
