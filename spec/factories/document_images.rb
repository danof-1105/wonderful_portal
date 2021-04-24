# == Schema Information
#
# Table name: document_images
#
#  id          :bigint           not null, primary key
#  image       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :bigint           not null
#
# Indexes
#
#  index_document_images_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#
FactoryBot.define do
  factory :document_image do
    image { Faker::Internet.url }
    document
  end
end
