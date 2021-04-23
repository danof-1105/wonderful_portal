# == Schema Information
#
# Table name: comments
#
#  id          :bigint           not null, primary key
#  body        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_comments_on_document_id  (document_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "バリデーションのチェック" do
    subject { comment }

    let(:user) { create(:user) }
    let(:user_directory) { create(:user_directory, user: user) }
    let(:document) { create(:document, writer: user, owner: user, user_directory: user_directory) }
    context "body がある時" do
      let(:comment) { build(:comment, document: document, user: user) }
      it "コメント登録される" do
        expect(subject).to be_valid
      end
    end

    context "body がない時" do
      let(:comment) { build(:comment, body: nil, document: document, user: user) }
      it "コメント登録できない" do
        expect(subject).not_to be_valid
      end
    end
  end
end
