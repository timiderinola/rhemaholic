class ContactsController < ApplicationController
  before_filter :get_user

  def get_user
      @user = current_user if signed_in?
  end
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      render :new
    else
      flash.now[:alert] = 'Cannot send message.'
      render :new
    end
  end
end