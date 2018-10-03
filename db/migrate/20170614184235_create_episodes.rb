class CreateEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :episodes do |t|
      t.integer :show_id
      t.integer :episode
      t.string :title
      t.text :description
      t.datetime :published_on
      t.string :status

      t.timestamps
    end
  end
end
