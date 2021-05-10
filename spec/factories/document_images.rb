# == Schema Information
#
# Table name: document_images
#
#  id         :bigint           not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :document_image do
    image { "MyString" }
  end
end
