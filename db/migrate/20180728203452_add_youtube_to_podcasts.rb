class AddYoutubeToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :youtube, :string
  end
end
