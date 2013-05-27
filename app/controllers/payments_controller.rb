class PaymentsController < ApplicationController
  load_and_authorize_resource
  before_filter :signed_in_user

  def new 
    @payment = Payment.new(:existing_address => "existing")
    @address = BookAddress.new
    @addresses = current_user.book_addresses
  end

  def create
    unless current_order.stage.zero?
      redirect_to orders_path
      return
    end
    @payment = current_order.build_payment(params[:payment])
    if @payment.existing_address == "new"
      @address = BookAddress.new(params[:address])
      @address.user = current_user
      if @address.save
      else
        @addresses = current_user.book_addresses
        render 'new'
        return
      end
    else
      @address = BookAddress.find(@payment.billing_address_id)
    end
    @billing_address = BillingAddress.create(@address.attributes.except('type','created_at','updated_at','id'))
    @payment.billing_address = @billing_address
    if @payment.valid?
      if @payment.purchase current_order.price_in_pence
        unless @payment.save
          @addresses = current_user.book_addresses
          @address = @payment.address
          render 'new'
        end
      else
        @addresses = current_user.book_addresses
        @address = @payment.address
        render 'new'
      end
    else
      @addresses = current_user.book_addresses
      @address = @payment.address
      render 'new'
    end
  end
end
