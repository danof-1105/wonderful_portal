# == Schema Information
#
# Table name: communities
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  community_owner_id :bigint           not null
#
# Indexes
#
#  index_communities_on_community_owner_id  (community_owner_id)
#  index_communities_on_name                (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (community_owner_id => users.id)
#
class Community < ApplicationRecord
  has_many :community_users, dependent: :destroy
  has_many :users, through: :community_users
  has_many :have_documents, class_name: "Document", as: :owner, dependent: :nullify
  has_many :community_directories, dependent: :destroy
  belongs_to :community_owner, class_name: "User", foreign_key: :community_owner_id
  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true
end
