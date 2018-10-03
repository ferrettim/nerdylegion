class HostOption < ApplicationRecord
  belongs_to :user
  belongs_to :podcast
end
