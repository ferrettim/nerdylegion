class AddAverageToPodcast < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :average, :integer
  end
end
