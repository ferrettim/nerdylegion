class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :name
      t.text :description
      t.string :keywords
      t.string :favicon
      t.string :email
      t.string :patreon
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :twitch
      t.string :reddit

      t.timestamps
    end
  end
end
