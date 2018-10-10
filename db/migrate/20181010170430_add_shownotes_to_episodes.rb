class AddShownotesToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :shownotes, :text
  end
end
