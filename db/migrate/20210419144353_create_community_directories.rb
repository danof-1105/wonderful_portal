class CreateCommunityDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :community_directories do |t|
      t.string :name, null: false
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
