class CreateUserDirectories < ActiveRecord::Migration[6.1]
  def change
    create_table :user_directories do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.references :directory, null: false, foreign_key: { to_table: :user_directories }

      t.timestamps
    end
  end
end
