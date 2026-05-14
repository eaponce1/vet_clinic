class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  # AUTHENTICATION
  before_action :authenticate_user!, unless: :public_page?

  # DEVISE STRONG PARAMETERS
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:first_name, :last_name]
    )

    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:first_name, :last_name]
    )
  end

  private

  def public_page?
    controller_name == "owners" && action_name == "index"
  end
end
