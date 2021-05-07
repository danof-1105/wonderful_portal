# == Schema Information
#
# Table name: document_images
#
#  id         :bigint           not null, primary key
#  image_path :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DocumentImage < ApplicationRecord
  mount_uploader :image_path, ImageUploader
end
