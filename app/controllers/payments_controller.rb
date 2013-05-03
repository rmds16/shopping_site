class PaymentsController < ApplicationController
  load_and_authorize_resource
  before_filter :signed_in_user

  def new 
    @payment = Payment.new(:existing_address => "existing")
    @address = Address.new
    @addresses = current_user.addresses
  end

  def create
    unless current_order.stage.zero?
      redirect_to orders_path
      return
    end
    @payment = current_order.build_payment(params[:payment])
    if @payment.existing_address == "new"
      @address = Address.new(params[:address])
      @address.user = current_user
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
        unless @payment.save
          @addresses = current_user.addresses
          @address = @payment.address
          render 'new'
        end
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
