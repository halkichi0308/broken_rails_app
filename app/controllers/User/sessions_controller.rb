# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  #def new
  #  super
  #end

  # POST /resource/sign_in
  def create
    # [vulnerability]: SQLi
    # [Safe pattern]:
    # self.resource = warden.authenticate!(auth_options)
    # Refer to https://github.com/heartcombo/devise/blob/8593801130f2df94a50863b5db535c272b00efe1/app/controllers/devise/sessions_controller.rb#L17

    # self.resourceにはDBから取得したユーザインスタンスが格納される
    begin
      self.resource = User.find_by("email='#{params[:user][:email]}'")
    rescue => e
      errMsg = e.to_s
    end

    # ユーザが存在しなかった場合の処理
    if resource.nil?
      flash[:notice] = errMsg||I18n.t('session.error.not_found_in_database')
      redirect_back fallback_location: new_user_session_path and return
    end

    # PW確認処理
    unless is_passwd_match(resource.encrypted_password, params[:user][:password])
      set_flash_message!(:notice, :not_found_in_database)
      redirect_back fallback_location: new_user_session_path and return
    end
    
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?

    unless params[:user][:redirect] == ""
      redirect_to params[:user][:redirect] and return
    end

    respond_with resource, location: after_sign_in_path_for(resource)
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
  def is_passwd_match(passwd_hash, raw_passwd)
    return BCrypt::Password.new(passwd_hash) == raw_passwd
  end
end
