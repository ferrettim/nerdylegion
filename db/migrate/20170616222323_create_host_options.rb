class CreateHostOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :host_options do |t|
      t.references :user, foreign_key: true
      t.references :podcast, foreign_key: true

      t.timestamps
    end
  end
end
