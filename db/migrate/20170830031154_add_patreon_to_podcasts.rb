class AddPatreonToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :patreon, :string
  end
end
