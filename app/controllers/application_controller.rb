class ApplicationController < ActionController::Base
  before_action :access_logger

  private

  # The logs you got are writeen to  "/var/log/access.log"
  def access_logger
    Rails.application.config.another_logger.info("#{request.method} '#{request.path}' #{request.version} from: #{request.remote_ip}")
  end
end
