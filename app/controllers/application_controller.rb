class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pagy::Backend
  protected

  $settings_exist = Setting.count == 1
  $setting = Setting.first

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :imageurl, :twitter, :admin, :podcaster, :analytics, :invite])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :current_password, :imageurl, :twitter])
  end
end
