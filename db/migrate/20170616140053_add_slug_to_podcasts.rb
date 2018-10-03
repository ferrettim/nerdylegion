class AddSlugToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :slug, :string
    add_index :podcasts, :slug, unique: true
  end
end
