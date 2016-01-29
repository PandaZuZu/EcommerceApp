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

  def edit
    @product = Product.find params[:product_id]
  end

  def update
    @product = Product.find params[:id]
    if @product && @product.update(new_product_params)
      redirect_to controller: 'home', action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find params[:id]
    if @product
      @product.destroy
    end
    redirect_to controller: 'home', action: 'index'
  end

  def view
    @product = Product.find params[:product_id]
    @buy_units = 1;
  end

  def add
    @product = Product.find params[:product_id]
    if params[:add].to_i < @product.quantity
      @buy_units = params[:add].to_i + 1
    else
      @buy_units = @product.quantity
    end

    render 'view'
  end

  def buy
    session[:order_id] = nil
    @product = Product.find params[:product_id]

    @current_user = User.find session[:user_id]

    if session[:order_id] == nil
      @order = Order.new
      @order.user_id = @current_user.id
      @product.units = 0;
      @order.save

      session[:order_id] = @order.id
    else
      @order = Order.find session[:order_id]
    end

    @new_product = @product
    if @new_product.units != nil
      if @new_product.units + params[:buy_units].to_i <= @product.quantity
        @new_product.units = @new_product.units + params[:buy_units].to_i
      else
        @new_product.units = @product.quantity
      end
    else
      @new_product.units = params[:buy_units]
    end

    @new_product.save

    @order.products << @new_product
    @current_user.orders << @order

    redirect_to controller: 'home', action: 'index'
  end

  def check_out
    @current_user = User.find session[:user_id]
    @current_user.orders.each do |o|
      o.products.each do |p|
        p.quantity -= p.units
        p.units = 0
        p.save
      end
    end
    @current_user.orders.destroy_all
    session[:order_id] = nil

    redirect_to controller: 'home', action: 'index'
  end

  def view_orders
    @all_users = User.all          
  end

  def view_cart
    @current_user = User.find session[:user_id]
    @orders = @current_user.orders
  end

  private
  def new_product_params
    params.require(:product).permit(:name, :description, {pictures: []}, :quantity, :price)
  end

end
