class Users::OmniauthCallbackController < Devise::OmniauthCallbacksController

  def facebook
    if user_signed_in?
      if current_user.link_account_from_omniauth(request.env["omniauth.auth"])
        flash[:notice] = "Account successfully linked"
        redirect_to root_url and return
      end
    end

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end
