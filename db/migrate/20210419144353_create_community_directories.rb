class CreateCommunityDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :community_directories do |t|
      t.string :name, null: false
      t.references :directory, null: false, foreign_key: { to_table: :community_directories }
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
