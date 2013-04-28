class ProductsController < ApplicationController

  def index
    @products = Product.paginate :page => params[:page], :per_page => 18, :order => :name
  end

  def show
    @product = Product.find(params[:id])
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

  def create
    @product = Product.new(params[:product])
    if @product.save
      @product.update_attribute(:user_id, current_user.id)
      redirect_to user_url(current_user.id)
    else
      render "new"
    end
  end

  def update
    @product = Product.find(params[:id])
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
  end

end
