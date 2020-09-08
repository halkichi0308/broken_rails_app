class AdminController < ApplicationController
  def products
  end
  def login
    redirect_to new_user_session_path(redirect: admin_login_url)
  end
end
