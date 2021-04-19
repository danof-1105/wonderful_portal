# == Schema Information
#
# Table name: communities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Community, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
