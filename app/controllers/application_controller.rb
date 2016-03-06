class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  #confirms a logged-in user
  def logged_in_user
    unless signed_in?
      store_location
      redirect_to signin_path,
                  alert: "You need to be signed in to acces this page."
    end
  end
end
