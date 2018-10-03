class AddIndexToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_index(:episodes, [:published_on, :title, :status])
  end
end
