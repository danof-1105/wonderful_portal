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
  pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { create(:user, name: "NAME", email: "sample@example.com", password: "sample12") }
  let(:user_directory) { create(:user_directory, name: "user1", user_id: user.id) }
  let(:document) { create(:document, title: "Title", body: "Body", writer_id: user.id, owner: user, user_directory_id: user_directory.id) }
  fcontext "body がある時" do
    let(:comment) { build(:comment, document_id: document.id, user_id: user.id) }
    it "コメント登録される" do
      expect(comment).to be_valid
    end
  end
  fcontext "body がない時" do
    let(:comment) { build(:comment, body: nil, document_id: document.id, user_id: user.id) }
    it "エラーする" do
      expect(comment).not_to be_valid
    end
  end
end
