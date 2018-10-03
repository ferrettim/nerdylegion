class AddFieldsToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :download_size, :string
    add_column :episodes, :duration, :string
  end
end
