class Account::UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "更新成功"
      redirect_to account_users_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end
end
