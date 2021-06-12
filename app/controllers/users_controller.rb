class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]

  def index
    @users = User.page(params[:page]).per(3)
  end

  def show
    @user = User.find(params[:id])
  end
end
