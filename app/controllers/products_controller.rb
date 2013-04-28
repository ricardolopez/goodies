class ProductsController < ApplicationController

  helper_method :creator

  def index
    @products = Product.paginate :page => params[:page], :per_page => 18, :order => :name
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
    @product.update_attribute(:view_count, @product.view_count+1)
  end

  def new
    @product = Product.new
  end

  def edit
    @user = User.find_by_id(Product.find(params[:id]).user_id)
    if @user == current_user
      @product = Product.find(params[:id])
    else
      render "show"
    end
  end

  def most_recent
    @products = Product.paginate :page => params[:page], :per_page => 18, :order => 'created_at DESC'
    render "index"
  end

  def most_popular
    @products = Product.paginate :page => params[:page], :per_page => 18, :order => 'view_count DESC'
    render "index"
  end

  def my_products
    @user = User.find(session[:user_id])
    @products = Product.find_all_by_user_id(@user.id, :order => 'created_at DESC')
    render "my_products"
  end

  def user_products
    @user = User.find(params[:id])
    @products = Product.find_all_by_user_id(@user.id, :order => 'created_at DESC')
    render "user_products"
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      @product.update_attribute(:user_id, current_user.id)
      redirect_to my_products_path(current_user.id)
    else
      render "new"
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to product_url(params[:id])
    else
      render "edit"
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
    @product.destroy
    redirect_to :my_products
  end

  private

  def creator(product_id)
    @product = Product.find(product_id)
    @creator = User.find(@product.user_id)
  end

end
