class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	# before_action :configure_permitted_parameters, if: :devise_controller?
	# before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to authenticated_root_path, alert: exception.message
  end

	protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up,
  #     keys: [:email, :username, :password, :password_confirmation, :remember_me])
  #   devise_parameter_sanitizer.permit(:sign_in,
  #     keys: [:login, :password, :password_confirmation])
  # end
end
