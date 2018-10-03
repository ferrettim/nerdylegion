class AddAnalyticsToPodcasts < ActiveRecord::Migration[5.1]
  def change
    add_column :podcasts, :today, :integer
    add_column :podcasts, :yesterday, :integer
    add_column :podcasts, :thisweek, :integer
    add_column :podcasts, :lastweek, :integer
    add_column :podcasts, :thismonth, :integer
    add_column :podcasts, :lastmonth, :integer
  end
end
