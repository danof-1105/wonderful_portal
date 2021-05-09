# == Schema Information
#
# Table name: document_images
#
#  id         :bigint           not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DocumentImage < ApplicationRecord
  mount_uploaders :image, ImageUploader
end
