class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
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
    @user = User.find(params[:id])
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }

      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  def destroy
    if @user.id == current_user.id
      redirect_to admin_users_url, notice: "You can not delete signed in user"
      @admins = User.admins
    elsif @admins == 1
      redirect_to admin_users_url, notice: "Atleast one admin must remain!"
    else
      @user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation, :user_type)
  end
 end