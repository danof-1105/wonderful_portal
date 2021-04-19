class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, :null => false
    add_column :users, :image, :string
  end
end
