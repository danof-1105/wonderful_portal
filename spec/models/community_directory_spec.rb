# == Schema Information
#
# Table name: community_directories
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  community_id :bigint           not null
#
# Indexes
#
#  index_community_directories_on_community_id  (community_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_id => communities.id)
#
require "rails_helper"

RSpec.describe CommunityDirectory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
