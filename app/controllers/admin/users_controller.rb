class Admin::UsersController < ApplicationController
  before_action :authorize
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :give_users_right_to_admin, only: [:index,:new,:create,:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:destroy]
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
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
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
  def check_admin
    @admins = 0
    User.all.each do |user|
      if user.user_type == 'admin'
        @admins += 1
      end
    end
    if @admins == 1
      redirect_to users_path, notice: 'At leat one admin must remain'
    else
      @user.destroy
      redirect_to users_url, notice: 'User has successfully destroyed'
    end
  end
 end