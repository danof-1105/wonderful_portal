class CreateDocumentImages < ActiveRecord::Migration[6.1]
  def change
    create_table :document_images do |t|
      t.string :image, null: false
      t.references :document, null: false, foreign_key: true

      t.timestamps
    end
  end
end
