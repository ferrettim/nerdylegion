class AddPathToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :path, :string
  end
end
