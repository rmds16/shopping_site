require 'spec_helper'

describe Payment do
  before do
    @delivery_address = FactoryGirl.build(:delivery_address)
    @user = FactoryGirl.create(:user)
    @delivery_address.user = @user
    @delivery_address.save
    @order = @user.orders.new(:delivery_address_id => @delivery_address.id)
    @order.save
    @item = FactoryGirl.create(:item)
    @order.add_item(@item.id)
    @order.save
    @billing_address = FactoryGirl.build(:billing_address)
    @billing_address.user = @user
    @billing_address.save
    @payment = FactoryGirl.build(:payment)
    @payment.billing_address_id = @billing_address.id
    @payment.order_id = @order.id
    @payment.save
  end

  subject { @payment }

  it { should respond_to(:card_number) }
  it { should respond_to(:verification_value) }
  it { should respond_to(:card_type) }
  it { should respond_to(:expiry_date) }
  it { should respond_to(:billing_address_id) }
  it { should respond_to(:existing_address) }

  it { should be_valid }

  describe "process payment" do
    describe "with valid card details" do
      before do
        @response = @payment.purchase @order.price_in_pence
      end
      subject { @response }
      it { should be_true }
    end

    describe "with invalid card details" do
      before do
        @payment.card_number = '4111111111111112'
        @response = @payment.purchase @order.price_in_pence
      end
      subject { @response }
      it { should_not be_true }
    end
  end
end
