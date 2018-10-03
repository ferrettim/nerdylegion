class AddProducersToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :producer_id, :integer
    add_index :podcasts, :producer_id
  end
end
