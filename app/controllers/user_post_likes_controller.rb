class UserPostLikesController < ApplicationController
  def create
    @user = User.includes(:posts).find(params[:user_id]) # Eager load associated posts
    @post = @user.posts.includes(:author, :comments).find(params[:post_id]) # Eager load author and comments
    @like = Like.new(author: current_user, post: @post)

    if @like.save
      redirect_to user_posts_path(@user), notice: 'Like was successfully created.' # Redirect to user's posts index
    else
      redirect_to user_posts_path(@user), alert: 'There was an error creating the like.' # Redirect to user's posts index
    end
  end
end
