class AddBannerToAbouts < ActiveRecord::Migration[5.2]
  def change
    add_column :abouts, :bannerurl, :string
  end
end
