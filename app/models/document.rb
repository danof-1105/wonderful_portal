# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  body              :text
#  owner_type        :string           not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  owner_id          :bigint           not null
#  user_directory_id :bigint           not null
#  writer_id         :bigint           not null
#
# Indexes
#
#  index_documents_on_owner              (owner_type,owner_id)
#  index_documents_on_user_directory_id  (user_directory_id)
#  index_documents_on_writer_id          (writer_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_directory_id => user_directories.id)
#  fk_rails_...  (writer_id => users.id)
#
class Document < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :community_directory_documents, dependent: :destroy
  has_many :community_directories, through: :community_directory_documents
  belongs_to :user_directory
  belongs_to :writer, class_name: "User"
  belongs_to :owner, polymorphic: true

  validates :title, length: { maximum: 50 }, presence: true
end
