class AddMorehostsToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :user2_id, :integer
    add_index :podcasts, :user2_id
    add_column :podcasts, :user3_id, :integer
    add_index :podcasts, :user3_id
  end
end
