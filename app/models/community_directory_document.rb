# == Schema Information
#
# Table name: community_directory_documents
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  community_directory_id :bigint           not null
#  document_id            :bigint           not null
#
# Indexes
#
#  index_community_directory_documents_on_community_directory_id  (community_directory_id)
#  index_community_directory_documents_on_document_id             (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_directory_id => community_directories.id)
#  fk_rails_...  (document_id => documents.id)
#
class CommunityDirectoryDocument < ApplicationRecord
  belongs_to :document
  belongs_to :community_directory
end
