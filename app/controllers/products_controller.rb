class ProductsController < ApplicationController

  def index
    @products = Product.all
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
  end

  def update
    @product = Product.find(params[:id])
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
  end

end
