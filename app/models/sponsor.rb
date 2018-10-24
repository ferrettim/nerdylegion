class Sponsor < ApplicationRecord
  mount_uploader :image, SponsorUploader
  validates_presence_of :name, :description, :image, :link
end
