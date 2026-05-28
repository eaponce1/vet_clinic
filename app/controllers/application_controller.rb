class ApplicationController < ActionController::Base
  include Pundit::Authorization

  allow_browser versions: :modern
  stale_when_importmap_changes

  # AUTHENTICATION
  before_action :authenticate_user!, unless: :public_page?

  # DEVISE STRONG PARAMETERS
  before_action :configure_permitted_parameters, if: :devise_controller?

  # PUNDIT ERROR HANDLER
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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
    false
  end

  # PUNDIT REDIRECT
  def user_not_authorized

    redirect_path =
      if current_user&.owner?
        owner_path(current_user.owner)

      elsif current_user&.vet?
        appointments_path

      else
        root_path
      end

    redirect_to redirect_path,
                alert: "You are not authorized to perform this action."
  end
end