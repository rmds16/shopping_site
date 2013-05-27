class OrdersController < ApplicationController
  load_and_authorize_resource
  before_filter :signed_in_user

  def new
    @order = Order.new
    @addresses = current_user.book_addresses
    @order.existing_address = @addresses.size > 0 ? "existing" : "new"
    @address = BookAddress.new
  end

  def create
    @order = current_user.orders.new(params[:order])
    if @order.existing_address == "existing"
     @address = BookAddress.find(params[:order][:delivery_address_id])
    else
      @address = BookAddress.new(params[:address])
      @address.user = current_user
      if @address.save
      else
        @addresses = current_user.book_addresses
        render 'new'
        return 
      end
    end
    @delivery_address = DeliveryAddress.create(@address.attributes.except('type','created_at','updated_at','id'))
    @order.delivery_address = @delivery_address
    if @order.save
      session[:order_id] = @order.id
      current_basket.basket_items.each do |basket_item|
        @order.order_items.create(:item_id => basket_item.item_id, :qty => basket_item.qty)
      end
      current_basket.destroy
      redirect_to new_payment_path 
    else
      @addresses = current_user.book_addresses
      render 'new'
    end
  end

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end
end
