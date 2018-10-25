class AddMerchToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :merch, :string
  end
end
