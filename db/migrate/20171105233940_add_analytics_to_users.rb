class AddAnalyticsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :analytics, :boolean, null: false, default: "false"
  end
end
