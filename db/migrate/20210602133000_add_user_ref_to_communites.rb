class AddUserRefToCommunites < ActiveRecord::Migration[6.1]
  def change
    add_reference :communities, :community_owner, null: false, foreign_key: { to_table: :users }
  end
end
