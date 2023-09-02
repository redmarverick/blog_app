class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @users = User.includes(:posts) # Eager load associated posts
  end

  def show
    @user = User.includes(posts: [:comments, :likes]).find(params[:id]) # Eager load posts with comments and likes
  end
end
