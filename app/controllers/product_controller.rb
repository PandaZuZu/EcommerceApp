class ProductController < ApplicationController

  def new
    @new_product = Product.new
  end

  def create
    @new_product = Product.new(new_product_params)
    if @new_product.save
      redirect_to controller: 'home', action: 'index'
    else
      flash[:notice] = params[{pictures: []}]
      render 'new'
    end

  end


  def update
    @product = params[:product_id]
  end

  def destroy
  end

  private
  def new_product_params
    params.require(:product).permit(:name, :description, {pictures: []}, :quantity, :price)
  end
end
