class UsersController < ApplicationController
  before_action :find_user, only: [:destroy]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def update

  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
