class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  mount_uploader :imageurl, UserUploader
  validate :validate_invite, :on => :create
  attr_accessor :invite

  class << self
    def from_omniauth(auth)
      new_user = where(provider: auth.provider, uid: auth.uid).first_or_initialize
      new_user.email = auth.info.email

      new_user.password = Devise.friendly_token[0,20]
      new_user.skip_confirmation!
      new_user.save
      new_user
    end
  end

  def validate_invite
    if self.invite != ENV["INVITE_CODE"]
      self.errors[:base] << "The invitation code is invalid. Try again"
    end
  end

  def link_account_from_omniauth(auth)
    self.provider = auth.provider
    self.uid = auth.uid
    self.save
  end
end
