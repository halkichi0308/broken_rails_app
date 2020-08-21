# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
      # TODO Add authentication logic here.
      # When Access to /admin.
      if user_signed_in?
        if current_user.role != 'admin'
          # ログイン画面に飛ばされるが、ログインはしているのでtopに飛ばされてしまう
          # その時のメッセージは You are already signed in. となり、
          # なぜtopに飛ばされたのかわからなくなるため、
          # 最初からtopに飛ばして 権限がありません のほうが良いかと思います
          redirect_to new_user_session_path, alert: '権限がありません'
        end
      else
        redirect_to new_user_session_path(redirect: request.url), alert: 'ログイン'
      end 
    end

    def main
      render "main"
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
    
  end
end
