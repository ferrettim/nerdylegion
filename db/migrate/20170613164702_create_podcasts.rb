class CreatePodcasts < ActiveRecord::Migration[5.1]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.string :language
      t.boolean :mature
      t.string :status
      t.datetime :published_on
      t.string :twitter
      t.string :google
      t.string :itunes
      t.string :stitcher
      t.string :tunein

      t.timestamps
    end
  end
end
