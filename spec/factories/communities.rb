# == Schema Information
#
# Table name: communities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_communities_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :community do
    sequence(:name) {|n| "#{n}_#{Faker::Team.name}" }
  end
end
