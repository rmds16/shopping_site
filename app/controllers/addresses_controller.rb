class AddressesController < ApplicationController
  load_and_authorize_resource
  def new
    @address = BookAddress.new
  end

  def edit
    @address = BookAddress.find(params[:id]) 
  end

  def update
    @address = BookAddress.find(params[:id])
    if @address.update_attributes(params[:address])
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  def create
    @address = current_user.book_addresses.build(params[:address])
    if @address.save
      redirect_to addresses_path
    else
      render 'new'
    end
  end

  def show
    @addresses = BookAddress.find(params[:id])
  end

  def index
    if current_user
      @addresses = current_user.book_addresses 
    else
      redirect_to signin_path
    end
  end

  def destroy
    address = BookAddress.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end
end
