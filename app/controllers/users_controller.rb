class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

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
      redirect_to @user,
        notice: "Welcome. You're now a rhemaholic!"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user,
        notice: "Profile updated"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path,
      notice: "#{@user.name} has been deleted successfully."
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #confirms a logged-in user
    def logged_in_user
      unless signed_in?
        store_location
        redirect_to signin_path,
          alert: "You need to be signed in to acces this page."
      end
    end

    #confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to @user,
          alert: "You have been denied acces to the page requested. Please check this instead."
      end
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
