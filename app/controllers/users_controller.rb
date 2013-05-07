class UsersController < ApplicationController
  load_and_authorize_resource

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_back_or_default root_path
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
