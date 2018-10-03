class AddExtrasToEpisodes < ActiveRecord::Migration[5.1]
  def change
    add_column :episodes, :explicit, :string
    add_column :episodes, :type, :string
    add_column :episodes, :episodetype, :string
  end
end
