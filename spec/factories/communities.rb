# == Schema Information
#
# Table name: communities
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  community_owner_id :bigint
#
# Indexes
#
#  index_communities_on_community_owner_id  (community_owner_id)
#  index_communities_on_name                (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (community_owner_id => users.id)
#
FactoryBot.define do
  factory :community do
    sequence(:name) {|n| "#{n}_#{Faker::Team.name}" }
  end
end
