# == Schema Information
#
# Table name: communities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Community < ApplicationRecord
  has_many :community_users, dependent: :destroy
  has_many :users, through: :community_users
  has_many :have_documents, class_name: "Document", as: :owner, dependent: :nullify
  has_many :community_directories, dependent: :destroy
  validates :name, presence: true,
                   length: { maximum: 50 },
                   uniqueness: true
end
