# frozen_string_literal: true

class User::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  #def new
  #  super
  #end

  # POST /resource/password
  def create
    email = params[:user][:email]

    unless is_email_vaild(email)
      flash[:notice] = I18n.t('user.error.email_invalid')
      redirect_back fallback_location: new_user_password_path and return
    end
    #binding.pry
    super
    # email = params[:email][:to]
    # if User.exists?(email: email)
    #   NotificationMailer.send_confirm_to_user(email).deliver_later
    # end      
    #   # flash[:notice] = 'Email was sending. Please your Mail folder.'
    #   redirect_to new_user_password_path, notice: 'Email send. Please your Mail folder.'
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  def is_email_vaild(email)
    # [vulnerability]: Redos
    return email.match?(/^([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+$/)
  end
end
