class CreateCommunityDirectoryDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :community_directory_documents do |t|
      t.references :document, null: false, foreign_key: true
      t.references :community_directory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
