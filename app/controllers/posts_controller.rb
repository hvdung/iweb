class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    if @post.save(post_params)
      flash[:notice] = "Post created !"
      redirect_to post_path(@posts)
    else
      flash[:alert] = "Post creating error !"
      render :new
    end
  end

  def edit

  end

  def update
    @post = Post.update_attributes(post_params)
    if @post.save(post_params)
      flash[:alert] = "Post updated !"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Post updating error !"
      render :edit
    end
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end
end
