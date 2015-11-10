class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_url,
        notice: "Email sent with password reset instructions."
    else
      flash.now.alert = "Email address not found."
      render 'new'
    end
  end

  def edit
  end
end
