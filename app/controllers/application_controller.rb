# class ApplicationController < ActionController::Base
#   #   before_action :authenticate_user!

#   protect_from_forgery with: :exception

#   # prevent users to perfrom action without authentication
#   before_action :authenticate_user!

#   before_action :update_allowed_parameters, if: :devise_controller?

#   protected

#   def update_allowed_parameters
#     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
#     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
#   end

#   def after_sign_out_path_for(_resource_or_scope)
#     new_user_session_path
#   end
# end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user
  def after_sign_in_path_for(_resource)
    users_path
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email bio password password_confirmation])
  end
end
