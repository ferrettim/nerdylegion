class AddPathToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :path, :string
  end
end
