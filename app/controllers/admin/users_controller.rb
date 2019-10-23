class Admin::UsersController < ApplicationController
  before_action :authorize
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :give_users_right_to_admin, only: [:index,:new,:create,:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end
  def new
    @user = User.new
  end
  def edit
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end
  def show
    
  end
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  def destroy
    if @user.id == current_user.id
      redirect_to admin_users_url, notice: "You can not delete signed in user"
      @admins = User.admins
    elsif @admins == 1
      redirect_to admin_users_url, notice: "At least one admin must remain!"
    else
      @user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def give_users_right_to_admin
    unless current_user && current_user.user_type == "admin"
      redirect_to root_url, notice: "only admin user can access this page"
    end
  end
  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation)
  end
 end