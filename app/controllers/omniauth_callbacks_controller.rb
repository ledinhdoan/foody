class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def create
    @user = User.from_omniauth request.env["omniauth.auth"]
    if @user.persisted?
      set_flash_message :notice, :success, kind: :"Facebook"
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
