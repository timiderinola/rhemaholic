class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :check_reset_link, only: [:edit]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_url,
        notice: "Please check your email for password reset instructions."
    else
      flash.now.alert = "The email supplied is not associated with any account."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user
      cookies[:remember_token] = @user.remember_token
      redirect_to @user,
          notice: "Password has been reset successfully."
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
      unless @user && @user.authenticated?(:reset, params[:id])
        redirect_to root_path
      end
    end

    def check_reset_link
      if @user.password_reset_expired?
        redirect_to new_password_reset_url,
                    alert: "Password reset link has expired. Please kindly request for a new one."
      end
    end
end
