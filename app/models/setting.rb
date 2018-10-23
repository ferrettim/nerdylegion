class Setting < ApplicationRecord
  mount_uploader :favicon, SettingUploader
  validates_presence_of :name, :description, :title, :keywords, :favicon
end
