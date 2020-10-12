# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  #def new
  #  super
  #end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    unless params[:user][:redirect] == ""
      redirect_to params[:user][:redirect] and return
    end

    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # POST /api/v1/login
  def login
    personal = {'name' => 'Yamada', 'old' => 28}
    render :json => personal
  end
    # POST /api/v1/login
  def getlogin
    personal = {'name' => 'Yamada', 'old' => 28}
    render :json => personal
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
