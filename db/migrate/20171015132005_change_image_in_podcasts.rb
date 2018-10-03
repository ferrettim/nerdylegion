class ChangeImageInPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :logourl, :string
  end
end
