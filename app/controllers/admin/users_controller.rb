module Admin
  class UsersController < Admin::ApplicationController
    before_action :configure_permitted_parameters, :permitted_attributes, if: :devise_controller?
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = User.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    #binding.pry
    def permitted_attributes
      dashboard.permitted_attributes << %w(password password_confirmation)
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:update, keys: [:password,:password_confirmation])
    end
    def update
      if params[:user][:password] and params[:user][:password_confirmation]
        user = User.find_by(id:params[:id])
        user.password = params[:user][:password]
        user.password_confirmation = params[:user][:password_confirmation]
        user.save
      end
      super
    end
    def new      
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end
end
