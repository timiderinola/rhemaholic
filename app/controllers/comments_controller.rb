class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @comment.update_attribute(:micropost_id, @micropost.id)
      redirect_to @micropost,
                  notice: 'Comment was successfully created.'
    else
      redirect_to @micropost,
                  alert: 'Error creating comment, ' + @micropost.errors
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @micropost = Micropost.find(params[:micropost_id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @micropost, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :micropost_id)
  end
end
