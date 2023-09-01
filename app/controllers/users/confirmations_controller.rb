class Users::ConfirmationsController < Devise::ConfirmationsController
  private

  # Override the redirect path after confirmation
  def after_confirmation_path_for(resource_name, resource)
    root_path # You can customize this path
  end
end
