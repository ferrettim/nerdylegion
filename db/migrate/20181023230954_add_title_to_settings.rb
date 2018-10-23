class AddTitleToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :title, :string
  end
end
