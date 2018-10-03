class Podcast < ApplicationRecord
  extend FriendlyId
	friendly_id :path, use: [:slugged, :finders]
  has_many :users
  has_many :episodes, dependent: :destroy
  mount_uploader :logourl, PodcastUploader
  validates_presence_of :logourl

end
