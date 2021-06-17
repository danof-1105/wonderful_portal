class AddColumnsToCommunities < ActiveRecord::Migration[6.1]
  def change
    change_table :communities, bulk: true do |t|
      t.string :slack_access_token
      t.boolean :slack_cooperation, default: false, null: false
    end
  end
end
