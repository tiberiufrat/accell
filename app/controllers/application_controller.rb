class ApplicationController < ActionController::Base
  include ForgeryProtection
  include SetPlatform

  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :gender, :title, :address, :birth_date, :newsletter, :email, :password, :profile_type])
            devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :gender, :title, :address, :birth_date, :newsletter, :email, :password, :current_password, :profile_type])
        end
end
