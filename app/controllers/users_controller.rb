class UsersController < ApplicationController
  
  helper_method :product_count

  def index
    @users = User.paginate :page => params[:page], :per_page => 25, :order => :username
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
      redirect_to users_url
    else
      flash.now.alert = "Be sure all parts of the form are filled and correct!"
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
      logger.info(@user.errors)
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @products = Product.find_all_by_user_id(params[:id])

    @products.each do |p|
      p.destroy
    end

    @user.destroy
    redirect_to log_out_path
  end

  private

  def product_count(user_id)
      @count = Product.count('user_id', :conditions => "user_id = #{user_id}")
  end

end
