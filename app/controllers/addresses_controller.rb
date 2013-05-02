class AddressesController < ApplicationController
  load_and_authorize_resource
  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id]) 
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  def create
    @address = current_user.addresses.build(params[:address])
    if @address.save
      redirect_to addresses_path
    else
      render 'new'
    end
  end

  def show
    @addresses = Address.find(params[:id])
  end

  def index
    if current_user
      @order = current_user.orders.new
      @addresses = current_user.addresses 
    else
      redirect_to signin_path
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end
end
