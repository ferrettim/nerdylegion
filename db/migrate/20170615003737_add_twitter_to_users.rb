class AddTwitterToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :twitter, :string
  end
end
