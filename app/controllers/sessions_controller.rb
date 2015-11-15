class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        sign_in user
        if params[:session][:remember_me] == '1'
          cookies.permanent[:remember_token] = user.remember_token
        else
          cookies[:remember_token] = user.remember_token
        end
        redirect_back_or root_url
      else
        redirect_to root_path,
          alert: "Account not acivated. Check your email for the activation link."
      end
    else
      flash.now.alert = "Invalid email/password combination."
      render "new"
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end
end
