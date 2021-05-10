# == Schema Information
#
# Table name: document_images
#
#  id         :bigint           not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe DocumentImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
