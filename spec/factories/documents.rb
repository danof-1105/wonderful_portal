# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  body              :text
#  images            :json
#  owner_type        :string           not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  owner_id          :bigint           not null
#  user_directory_id :bigint           not null
#  writer_id         :bigint           not null
#
# Indexes
#
#  index_documents_on_owner              (owner_type,owner_id)
#  index_documents_on_user_directory_id  (user_directory_id)
#  index_documents_on_writer_id          (writer_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_directory_id => user_directories.id)
#  fk_rails_...  (writer_id => users.id)
#
FactoryBot.define do
  factory :document do
    title { Faker::Game.title }
    body { Faker::Lorem.sentence }
    user_directory
    writer { user_directory.user }
    owner { user_directory.user }
  end
end
