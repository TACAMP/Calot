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
    @comment = Comment.find(params[:id])
    if @comment.user.id == current_user.id
      @comment.destroy
    else
      redirect_to request.referer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
