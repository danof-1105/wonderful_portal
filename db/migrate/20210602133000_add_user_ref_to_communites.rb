class AddUserRefToCommunites < ActiveRecord::Migration[6.1]
  def change
    add_reference :communities, :community_owner, foreign_key: { to_table: :users }
  end
end
