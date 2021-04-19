class ChangeForeignKeyForUserDirectories < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_directories, :user_directory_id, :directory_id
  end
end
