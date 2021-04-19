class ChangeColumnsAddNotnullOnCommunityDirectories < ActiveRecord::Migration[6.1]
  def change
    change_column_null :community_directories, :name, false
  end
end
