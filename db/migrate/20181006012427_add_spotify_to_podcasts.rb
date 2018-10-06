class AddSpotifyToPodcasts < ActiveRecord::Migration[5.2]
  def change
    add_column :podcasts, :spotify, :string
  end
end
