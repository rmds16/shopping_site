require 'spec_helper'

describe Payment do
  before do
    @address = FactoryGirl.build(:address)
    @user = FactoryGirl.create(:user)
    @address.user = @user
    @address.save
    @order = @user.orders.new
    @order.address_id = @address.id
    @order.save
    @item = FactoryGirl.create(:item)
    @order.add_item(@item.id)
    @order.save
    @payment = FactoryGirl.build(:payment)
    @payment.address_id = @address.id
    @payment.order_id = @order.id
    @payment.save
  end

  subject { @payment }

  it { should respond_to(:card_number) }
  it { should respond_to(:verification_value) }
  it { should respond_to(:card_type) }
  it { should respond_to(:expiry_date) }
  it { should respond_to(:address_id) }
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
