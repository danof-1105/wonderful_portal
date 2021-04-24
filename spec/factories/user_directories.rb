# == Schema Information
#
# Table name: user_directories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_directories_on_ancestry  (ancestry)
#  index_user_directories_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_directory do
    name { "MyString" }
    user
    ancestry { nil }
  end
end
