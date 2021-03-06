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

    context "body がある時" do
      let(:comment) { build(:comment) }
      it "コメント登録される" do
        expect(subject).to be_valid
      end
    end

    context "body がない時" do
      let(:comment) { build(:comment, body: nil) }
      it "コメント登録できない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:body][0][:error]).to eq :blank
      end
    end
  end
end
