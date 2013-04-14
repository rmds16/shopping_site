class UsersController < ApplicationController
  load_and_authorize_resource

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_to account_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = current_user
  end

  def edit
  end
  
  def update
  end
end
