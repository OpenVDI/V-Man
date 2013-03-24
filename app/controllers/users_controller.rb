class UsersController < ApplicationController

  before_filter :authenticate_user!

  # GET /users
  def index
    @users = User.all

    respond_with @users
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])

    respond_with @user
  end

  # GET /users/new
  def new
    @user = User.new

    respond_with @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    flash[:success] = 'User was successfully created.' if @user.save

    respond_with @user
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    is_updated = if params[:user][:password].empty?
                  @user.update_without_password(params[:user])
                 else
                   @user.update_with_password(params[:user])
                 end
    flash[:success] = 'User was successfully updated.' if is_updated

    respond_with @user
  end

  # DELETE /users/1
  def destroy
    @user = User.destroy(params[:id])

    respond_with @user
  end

end
