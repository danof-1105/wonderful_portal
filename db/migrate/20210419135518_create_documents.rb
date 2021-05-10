class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :title, null: false
      t.text :body
      t.references :user_directory, null: false, foreign_key: true
      t.references :writer, null: false, foreign_key: { to_table: :users }
      t.references :owner, polymorphic: true, null: false
      t.timestamps
    end
  end
end
