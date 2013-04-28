class OrdersController < ApplicationController
  load_and_authorize_resource
  before_filter :signed_in_user

  def new
    @order = Order.new
    @addresses = current_user.addresses
    @order.existing_address = @addresses.size > 0 ? "existing" : "new"
    @address = Address.new
  end

  def create
    @order = current_user.orders.new(params[:order])
    if @order.existing_address == "existing"
      @address = Address.find(params[:order][:address_id])
      @order.address = @address
    else
      @address = Address.new(params[:address])
      @address.user = current_user
      if @address.save
        @order.address = @address
      else
        @addresses = current_user.addresses
        render 'new'
        return 
      end
    end
    if @order.save
      session[:order_id] = @order.id
      current_basket.basket_items.each do |basket_item|
        @order.order_items.create(:item_id => basket_item.item_id, :qty => basket_item.qty)
      end
      current_basket.destroy
      redirect_to new_payment_path 
    else
      @addresses = current_user.addresses
      render 'new'
    end
  end
end
