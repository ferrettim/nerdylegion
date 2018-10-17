class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
