class AddIndexToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_index(:podcasts, [:title, :published_on, :status])
  end
end
