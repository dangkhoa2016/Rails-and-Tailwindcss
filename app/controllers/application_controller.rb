class ApplicationController < ActionController::Base
  include Pagy::Backend
  layout :layout_by_resource
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_user!(options = {})
    # super unless request.path == root_path
    super unless request.path == '/'
  end

  def layout_by_resource
    if devise_controller? && !is_edit_password?
      'devise'
    else
      'application'
    end
  end

  def is_edit_password?
    controller_name == 'registrations' && (action_name == 'edit' || action_name == 'update')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
