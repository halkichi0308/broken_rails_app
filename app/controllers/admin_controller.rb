class AdminController < ApplicationController
  def products
  end
  def login
    redirect_to "/users/sign_in?redirect=#{admin_login_url}"
  end
end
