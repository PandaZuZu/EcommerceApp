class HomeController < ApplicationController
  def index

  end

  def register
    @new_user = User.new
  end

  def create
    @new_user = User.new(register_params)
    if @new_user.save
      flash[:notice] = "Account " + @new_user.username.to_s + " was successfuly created!"
      redirect_to :action => index
    else
      flash[:notice] = "Error, could not create account!"
      render :action => 'register'
    end
  end

  private
  def register_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email)
  end

end
