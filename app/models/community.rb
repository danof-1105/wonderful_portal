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
  has_many :documents, foreign_key: :owner_id, dependent: :destroy
  has_many :community_directories, dependet: :destroy
end
