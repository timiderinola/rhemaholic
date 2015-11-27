class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      sign_in user
      cookies[:remember_token] = user.remember_token
      redirect_to user,
        notice: "Your account has been activated!"
    else
      redirect_to root_path,
        alert: "Invalid activation link!"
    end
  end
end
