class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comments = @post.comments
    @comment.post = @post
    if @comment.save
      @post.create_comment_notification(current_user, @comment.id)
      redirect_to post_path(@post)
    else
      flash.now[:danger] = 'コメントの内容を入力してください'
      render template: 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
