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
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :document
  validates :body, presence: true
end
