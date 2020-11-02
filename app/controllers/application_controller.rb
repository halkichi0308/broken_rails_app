class ApplicationController < ActionController::Base
  before_action :access_logger
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  # The logs you got are writeen to  "/var/log/access.log"
  def access_logger
    Rails.application.config.another_logger.info("#{request.method} '#{request.path}' #{request.version} from: #{request.remote_ip}")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:create) do |user_params|
      user_params.permit(:password, :password_confirmation)
    end  end
end
