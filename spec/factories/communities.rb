# == Schema Information
#
# Table name: communities
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  slack_access_token :string
#  slack_cooperation  :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  owner_id           :bigint
#
# Indexes
#
#  index_communities_on_name      (name) UNIQUE
#  index_communities_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
FactoryBot.define do
  factory :community do
    sequence(:name) {|n| "#{n}_#{Faker::Team.name}" }
    association :owner, factory: :user
  end
end
