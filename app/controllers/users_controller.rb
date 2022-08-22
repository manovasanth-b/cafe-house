class UsersController < ApplicationController
  def index
    if isCafeOwner || !current_user
      @user = User.new
      render "index"
    else redirect_to view_home_path     end
  end

  def create
    @user = User.new(user_params)
    @user.role = $USER_TYPE_OWNER

    if current_user &&
       current_user.role == $USER_TYPE_OWNER &&
       (user_params[:role].to_i == $USER_TYPE_CLERK || user_params[:role].to_i == $USER_TYPE_OWNER)
      @user.role = user_params[:role].to_i
    else
      @user.role = $USER_TYPE_CUSTOMER
    end

    if @user.save
      flash[:notice] = "Profile has been created successfully!"
      redirect_to view_login_path
    else
      render action: :index
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :role, :password_confirmation)
  end
end
