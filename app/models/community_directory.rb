# == Schema Information
#
# Table name: community_directories
#
#  id           :bigint           not null, primary key
#  ancestry     :string
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  community_id :bigint           not null
#
# Indexes
#
#  index_community_directories_on_ancestry      (ancestry)
#  index_community_directories_on_community_id  (community_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_id => communities.id)
#
class CommunityDirectory < ApplicationRecord
  has_many :community_directory_documents, dependent: :destroy
  has_many :documents, through: :community_directory_documents
  has_ancestry
  belongs_to :community
end
