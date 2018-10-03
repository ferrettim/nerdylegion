class AddImageurlToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :imageurl, :string
  end
end
