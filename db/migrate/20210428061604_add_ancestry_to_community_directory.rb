class AddAncestryToCommunityDirectory < ActiveRecord::Migration[6.1]
  def change
    add_column :community_directories, :ancestry, :string
    add_index :community_directories, :ancestry
  end
end
