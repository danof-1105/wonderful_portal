class AddColumnsToCommunities < ActiveRecord::Migration[6.1]
  def change
    change_table :communities, bulk: true do |t|
      t.string :slack_access_token
    end
  end
end
