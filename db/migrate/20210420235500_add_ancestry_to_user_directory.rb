class AddAncestryToUserDirectory < ActiveRecord::Migration[6.1]
  def change
    add_column :user_directories, :ancestry, :string
    add_index :user_directories, :ancestry
  end
end
