# == Schema Information
#
# Table name: communities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :community do
    name { "MyString" }
  end
end
