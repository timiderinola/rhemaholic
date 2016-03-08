class LongPostsController < ApplicationController
  before_action :set_post,         only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,      except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def show
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    current_user.microposts.create({content: 'A <%= @post.category %>: <%=link_to @post.title, @post %>' })
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fans
    @title = 'Post Fans'
    @post = Post.find(params[:id])
    @users = @post.fans.paginate(page: params[:page])
    render 'show_fans'
  end

  def like
    @post = Post.find(params[:id])
    @post.like!(current_user)
    respond_to do |format|
      format.html { redirect_to @post}
      format.js
    end
  end

  def unlike
    @post = Post.find(params[:id])
    @post.unlike!(current_user)
    respond_to do |format|
      format.html { redirect_to @post}
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content, :category)
  end
end
