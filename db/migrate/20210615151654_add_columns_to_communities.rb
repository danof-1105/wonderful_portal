class AddColumnsToCommunities < ActiveRecord::Migration[6.1]
  def change
    add_column :communities, :slack_access_token, :string
    add_column :communities, :slack_cooperation, :boolean, default: false, null: false
  end
end
