class UserPostLikesController < ApplicationController
  respond_to :js
  def create
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.includes(:author, :comments).find(params[:post_id])
    @like = Like.new(author: current_user, post: @post)

    if @like.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js { render 'error' } # Render the error.js.erb template
      end
    end
  end
end
