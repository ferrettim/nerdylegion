class AddAudiourlToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :audiourl, :string
  end
end
