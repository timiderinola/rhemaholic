class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_url, notice: "Post has been created." }
        format.js
      else
        @feed_items = []
        format.html { render 'static_pages/home' }
      end
    end
  end

  def destroy
    respond_to do |format|
      @micropost.destroy
      format.html { redirect_to request.referrer || root_url, notice: "Post has been deleted." }
      format.js { render :layout => false }
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
