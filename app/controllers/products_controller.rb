class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
  end

  def new
  end

  def create
    @product = Product.create( 
      name: params[:name], 
      description: params[:description], 
      price: params[:price], 
      quantity: params[:quantity]
    )
    redirect_to '/products/index'
  end

  def update
  end

  def destroy
  end

  def edit
  end
end
