class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :leaders, :followers]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    redirect_to signin_path unless signed_in?
    @user = User.friendly.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      redirect_to root_path, 
        notice: "Your account has been created. Please check your email to activate your account."
    else
      render 'new'
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      @user.update_attribute(:slug, @user.username)
      sign_in @user
      cookies[:remember_token] = @user.remember_token
      redirect_to @user,
        notice: "Profile updated"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    @user.destroy
    redirect_to users_path,
      notice: "#{@user.name} has been deleted successfully."
  end

  def following
    @title = "Following"
    @user = User.friendly.find(params[:id])
    @users = @user.leaders.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.friendly.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def follow
    @user = User.friendly.find(params[:id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user,
                                notice: "You are now following #{@user}" }
      format.js
    end
  end

  def unfollow
    @user = User.friendly.find(params[:id])
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user,
                                notice: "You stopped following #{@user}" }
      format.js
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
    end

    # def update_params
    #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # end

    #confirms the correct user
    def correct_user
      @user = User.friendly.find(params[:id])
      unless current_user?(@user)
        redirect_to request.referrer || @user,
          alert: "We're sorry. You have been denied access to the page requested."
      end
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
