class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @categories = Category.all
    @users = User.all

    if params[:cat_id].present?
      @posts = Post.joins(:relationships).where("category_id = ?", params[:cat_id]).paginate(:page => params[:page], :per_page => 16)
    elsif params[:user_id].present?
      @posts = Post.all.where("user_id = ?", params[:user_id]).paginate(:page => params[:page], :per_page => 16)
    elsif params[:cat_id].present? and params[:user_id].present?
      @posts = Post.joins(:relationships).where("category_id = :cat_id and user_id = :user_id", {cat_id: params[:cat_id], user_id: params[:user_id]}).paginate(:page => params[:page], :per_page => 16)
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 16)
    end

  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "Post created !"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Post creating error !"
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @post.update_attributes(post_params)
      flash[:alert] = "Post updated !"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Post updating error !"
      render :edit
    end
  end

  def show
    @categories = @post.relationships.all
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :desc, :thumbnail, category_ids:[])
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end
end
