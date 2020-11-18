class MypageController < ApplicationController
  before_action :require_login
  def index
  end

  def history
    #binding.pry
    @histories = History.where(user_name: current_user.email).page(params[:page]).order("created_at DESC").per(10)
    NotificationMailer.send_confirm_to_user("tmp").deliver
  end
  private
  def require_login
    unless user_signed_in?
      redirect_to new_user_session_path(redirect: request.url), alert: 'Please Login.'
    end 
  end
end

