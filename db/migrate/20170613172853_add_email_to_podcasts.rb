class AddEmailToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :email, :string
  end
end
