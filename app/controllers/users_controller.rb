class UsersController < ApplicationController
  
  def index
    @users = User.paginate :page => params[:page], :per_page => 24, :order => :username
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])
    @my_products = Product.find_all_by_user_id(params[:id])
    @my_products.sort_by{|a| a.created_at }
    @my_products.reverse!
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
    logger.info("*****************")
    logger.info(Paperclip.options[:command_path])
    logger.error(ENV['S3_KEY'])
    logger.error(ENV['S3_SECRET'])
    @user = User.find_by_id(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to users_url, notice: 'User #{@user.username} successfully updated.' 
    else
      logger.info(@user.errors)
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end

end
