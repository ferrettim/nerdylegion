class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean, null: false, default: "false"
    add_column :users, :podcaster, :boolean, null: false, default: "false"
  end
end
