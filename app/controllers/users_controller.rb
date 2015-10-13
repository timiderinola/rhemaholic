class UsersController < ApplicationController
  def show
    redirect_to signin_path unless signed_in?
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user, notice: "Welcome. You're now a rhemaholic!"
    else
      render "new"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
