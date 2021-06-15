# == Schema Information
#
# Table name: communities
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  slack_access_token :string
#  slack_cooperation  :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  owner_id           :bigint
#
# Indexes
#
#  index_communities_on_name      (name) UNIQUE
#  index_communities_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Community < ApplicationRecord
  has_many :community_users, dependent: :destroy
  has_many :users, through: :community_users
  has_many :have_documents, class_name: "Document", as: :owner, dependent: :nullify
  has_many :community_directories, dependent: :destroy
  belongs_to :owner, class_name: "User"
  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true
end
