class CommentsController < ApplicationController
  before_action:authenticate_user!,only:[:create,:destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    @post.create_notification_comment!(current_user , comment.id)
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
