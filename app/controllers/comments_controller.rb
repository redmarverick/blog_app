class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:author, :comments).find(params[:post_id]) # Eager load author and comments
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:author, :comments).find(params[:post_id]) # Eager load author and comments
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment added successfully.'
    else
      flash.now[:alert] = 'Comment could not be added.'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
