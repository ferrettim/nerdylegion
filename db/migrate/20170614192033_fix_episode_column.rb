class FixEpisodeColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :episodes, :show_id, :podcast_id
  end
end
