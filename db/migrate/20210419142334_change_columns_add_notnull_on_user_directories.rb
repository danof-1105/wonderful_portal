class ChangeColumnsAddNotnullOnUserDirectories < ActiveRecord::Migration[6.1]
  def change
    change_column_null :user_directories, :name, false
  end
end
