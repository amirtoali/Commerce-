class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
 
  allow_browser versions: :modern
    protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_stripe_key # add this line

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

  # add the code below
  private
    def set_stripe_key
      Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
    end
end
