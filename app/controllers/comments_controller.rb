class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.build(comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_to post
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
