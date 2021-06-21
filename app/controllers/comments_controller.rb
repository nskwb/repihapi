class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.build(comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to post_path(post)
    else
      render root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
