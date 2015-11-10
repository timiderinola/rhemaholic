class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      sign_in user
      redirect_to user,
        notice: "Account activated! Please sign in to continue."
    else
      redirect_to root_path,
        alert: "Invalid activation link!"
    end
  end
end
