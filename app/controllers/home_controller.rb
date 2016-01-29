class HomeController < ApplicationController

  before_filter :save_login_state, :only => [:create, :register, :login, :login_attempt]

  def index
    @products = Product.all
    if session[:user_id]
      @current_user = User.find session[:user_id]
    end
  end

  def register
    @new_user = User.new
  end

  def create
    @new_user = User.new(register_params)
    @new_user.is_admin = false
    if @new_user.save
      flash[:notice] = "Account " + @new_user.username.to_s + " was successfuly created!"
      redirect_to :action => 'login'
    else
      flash[:notice] = "Error, could not create account!"
      render action: 'register'
    end
  end

  def login
    flash[:notice] = nil
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to action: 'index'
    else
      flash[:notice] = 'Invalid username or password!'
      render 'login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to action: 'index'
  end


  private
  def register_params
    params.require(:user).permit(:username, :password_field, :password_field_confirmation, :email)
  end

end
