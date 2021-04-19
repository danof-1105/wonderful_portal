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
class UserDirectory < ApplicationRecord
  has_many :user_directories, foreign_key: :directory_id
  belongs_to :user
  belongs_to :user_directory
end
