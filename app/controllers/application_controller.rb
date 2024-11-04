class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token

  def authenticate_user!(options = {})
    # super unless request.path == root_path
    super unless request.path == '/'
  end

  def layout_by_resource
    if devise_controller?
      #  && (controller_name == 'registrations' && action_name == 'edit')
      'devise'
    else
      'application'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
