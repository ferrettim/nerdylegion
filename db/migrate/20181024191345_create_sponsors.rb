class CreateSponsors < ActiveRecord::Migration[5.2]
  def change
    create_table :sponsors do |t|
      t.string :name
      t.text :description
      t.string :link
      t.string :image
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
