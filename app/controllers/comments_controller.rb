class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    respond_to do |format|
      @post.create_comment_notification(current_user, @comment.id) if @comment.save
      format.js { render :index }
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.user == current_user
        @comment.destroy
        flash.now[:success] = 'コメントを削除しました'
        format.js { render :index }
      else
        flash.now[:alert] = 'コメントの削除はできません'
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
