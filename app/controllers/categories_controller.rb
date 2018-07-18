class CategoriesController < ApplicationController
  before_action :find_category, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate(:page => params[:page], :per_page => 10)
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created !"
      redirect_to categories_path
    else
      flash[:alert] = "Category creating error !"
      render :index
    end
  end

  def edit

  end

  def update
    if @category.update_attributes(category_params)
      flash[:alert] = "Category updated !"
      redirect_to categories_path
    else
      flash[:alert] = "Category updating error !"
      render :edit
    end
  end

  def show
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title, :desc, :parent_id)
  end

  def find_category
    @category = Category.find_by(id: params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
