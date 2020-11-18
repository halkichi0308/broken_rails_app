module Admin
  class UsersController < Admin::ApplicationController
    before_action :configure_permitted_parameters, :permitted_attributes, if: :devise_controller?
    #before_action :add_permitted_parameters
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


    def update
      if params[:user][:password] and params[:user][:password_confirmation]
        user = User.find_by(id:params[:id])
        user.password = params[:user][:password]
        user.password_confirmation = params[:user][:password_confirmation]
        user.save
      end
      super

    end
    def create
      # To avoid devise function(Strong Parameters)
      # https://github.com/heartcombo/devise#strong-parameters
      user = User.new()
      user.email = params[:user][:email]
      user.role = params[:user][:role]
      user.password = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
      user.save
      redirect_to admin_user_path(id: User.maximum(:id)), notice: 'User was successfully created.'
    end

    protected
    def permitted_attributes
      dashboard.permitted_attributes << %w(password password_confirmation)
    end
    def configure_permitted_parameters
      params.permit(user:[])

      devise_parameter_sanitizer.permit(:update, keys: [:password,:password_confirmation])
      devise_parameter_sanitizer.permit(:create, keys: [:password,:password_confirmation])
    end

  end
end
