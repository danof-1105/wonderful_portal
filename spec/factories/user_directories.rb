# == Schema Information
#
# Table name: user_directories
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  directory_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_user_directories_on_directory_id  (directory_id)
#  index_user_directories_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (directory_id => user_directories.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_directory do
    name { "MyString" }
    user { nil }
    user_directory { nil }
  end
end
