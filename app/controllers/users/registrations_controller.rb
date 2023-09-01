class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email_confirmation])
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:photo, :bio, :email_confirmation])
  end
end
