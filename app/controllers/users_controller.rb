class UsersController < ApplicationController
  def index
    @users = User.includes(:posts) # Eager load associated posts
  end

  def show
    @user = User.includes(posts: [:comments, :likes]).find(params[:id]) # Eager load posts with comments and likes
  end
end
