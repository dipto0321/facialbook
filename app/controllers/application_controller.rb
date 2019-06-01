# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: %i[first_name last_name birthday gender]])
    devise_parameter_sanitizer.permit(:account_update, keys: [profile_attributes: %i[first_name last_name birthday gender]])
  end
end
