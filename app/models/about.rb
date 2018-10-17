class About < ApplicationRecord
  mount_uploader :bannerurl, AboutUploader
  validates_presence_of :bannerurl
end
