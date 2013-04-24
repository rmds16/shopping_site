class PaymentsController < ApplicationController
  load_and_authorize_resource

  def new 
    @payment = Payment.new(:existing_address => "1")
    @address = Address.new
    @addresses = current_user.addresses
  end

  def create
    @payment = current_order.payments.new(params[:payment])
    if @payment.existing_address == "0"
      @address = current_user.addresses.new(params[:address])
      if @address.save
        @payment.address_id = @address.id
      else
        @addresses = current_user.addresses
        render 'new'
        return
      end
    end
    if @payment.valid?
      if @payment.purchase current_order.price_in_pence
        @payment.save
      else
        @addresses = current_user.addresses
        @address = @payment.address
        render 'new'
      end
    else
      @addresses = current_user.addresses
      @address = @payment.address
      render 'new'
    end
  end
end
