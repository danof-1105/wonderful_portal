# == Schema Information
#
# Table name: user_directories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_directories_on_ancestry  (ancestry)
#  index_user_directories_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserDirectory < ApplicationRecord
  belongs_to :user
  has_many :documents, dependent: :nullify
  has_ancestry

  validates :name, length: { maximum: 20 }, presence: true
  validates :ancestry, ancestry: true, allow_nil: true

  def do_not_have?
    self.documents.blank? && self.is_childless?
  end
end
