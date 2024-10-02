class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_logged_in_user

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :address, :email])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address, :email])
  end

  private

  def redirect_logged_in_user
    redirect_to items_path if user_signed_in? && request.path == root_path
  end

  def after_sign_in_path_for(resource)
    items_path
  end
end
