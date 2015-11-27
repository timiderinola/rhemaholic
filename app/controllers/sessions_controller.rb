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
          alert: "Your account is yet to be activated. Please check your email for the activation link."
      end
    else
      if user
        flash.now.alert = "Incorrect password. Forgot password? Follow the 'Forgot password' link to set a new password."
        render "new"
      else
        flash.now.alert = "The email supplied is not associated with any account."
        render "new"
      end
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_path
  end
end
