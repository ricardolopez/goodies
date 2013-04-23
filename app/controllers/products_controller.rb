class ProductsController < ApplicationController

  def index
    @products = Product.paginate :page => params[:page], :per_page => 1, :order => :name
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @user = User.find_by_id(params[:id])
    if @user == current_user
      @product = Product.find(params[:id])
    else
      render "show"
    end
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to products_url
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
