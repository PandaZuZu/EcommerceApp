class HomeController < ApplicationController

  before_filter :save_login_state, :only => [:create, :register, :login, :login_attempt]

  def index

  end

  def register
    @new_user = User.new
  end

  def create
    @new_user = User.new(register_params)
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
    myUser = User.find_by username: params[:username]
    flash[:notice] = myUser.username

    authorized_user = User.authenticate(params[:username], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to action: 'index'
    else
      flash[:notice] = 'Invalid username or password!' + myUser.password.to_s
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
