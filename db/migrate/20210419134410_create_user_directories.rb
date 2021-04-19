class CreateUserDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :user_directories do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.references :user_directory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
