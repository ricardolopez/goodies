class UsersController < ApplicationController
  
  def index
    @users = User.paginate :page => params[:page], :per_page => 1, :order => :username
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect_to users_url, notice: 'User #{@user.username} successfully created.'
    else
      render "new"
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
    if @user != current_user
      redirect_to users_url, notice: 'Cannot edit this profile!'
    end
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to users_url, notice: 'User #{@user.username} successfully updated.' 
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end
end
