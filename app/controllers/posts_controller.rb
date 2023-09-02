class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:index, :show, :new, :create]
  before_action :find_post, only: [:show]
  load_and_authorize_resource

  def index
    @post = Post.new(author: current_user)
    @posts_per_page = 2
    @total_pages = (@user.posts.count.to_f / @posts_per_page).ceil
    @page = (params[:page] || 1).to_i
    offset = (@page - 1) * @posts_per_page

    @user = User.find(params[:user_id])
    @posts = @user.posts.ordered_by_id_desc
      .includes(:comments, :likes) # Eager load comments and likes
      .limit(@posts_per_page)
      .offset(offset)
  end

  def show
    @comment = Comment.new
    @post = @user.posts.includes(:comments, :likes).find(params[:id])
  end

  def new
    @post = Post.new
    @post.author = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post created successfully.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @user = User.find(params[:user_id])

    if @post.destroy
      redirect_to user_posts_path(@user), notice: 'Post deleted successfully.'
    else
      redirect_to user_posts_path(@user), alert: 'Failed to delete the post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = @user.posts.find(params[:id])
  end

  def like
    @post = Post.find(params[:id])
    @post.increment!(:likes_counter)
    respond_to do |format|
      format.html { redirect_to user_post_path(@user, @post), notice: 'Post liked!' }
      format.js
    end
  end
end
