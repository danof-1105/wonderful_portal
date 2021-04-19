# == Schema Information
#
# Table name: community_users
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  community_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_community_users_on_community_id  (community_id)
#  index_community_users_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (community_id => communities.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe CommunityUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
