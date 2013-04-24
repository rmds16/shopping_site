class OrdersController < ApplicationController
  load_and_authorize_resource
  def new
    if current_user
      @order = Order.new(:existing_address => "1")
      @addresses = current_user.addresses
      @address = Address.new
    else
      redirect_to signin_path
    end
  end

  def create
    @order = current_user.orders.build
    @order.existing_address = params[:order][:existing_address]
    
      Rails.logger.debug params.inspect
    if @order.existing_address == "1"
      @address = Address.find(params[:order][:address_id])
      @order.address_id = @address.id 
    else
      @address = current_user.addresses.new(params[:address])
      if @address.save
        @order.address_id = @address.id
      else
        @addresses = current_user.addresses
        @order.existing_address = "0"
        render 'new'
        return 
      end
    end
    @order.save!
    session[:order_id] = @order.id
    current_basket.basket_items.each do |basket_item|
      @order.order_items.create(:item_id => basket_item.item_id, :qty => basket_item.qty)
    end
    current_basket.destroy
    redirect_to new_payment_path 
  end
end
