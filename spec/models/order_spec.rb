require 'spec_helper'

describe Order do
  before do
    @address = FactoryGirl.build(:delivery_address)
    @user = FactoryGirl.create(:user)
    @address.user = @user
    @address.save
    @order = @user.orders.new
    @order.delivery_address_id = @address.id
  end

  subject { @order }
 
  it { should respond_to(:delivery_address_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:stage) }

  it { should be_valid }
 
  describe "when address_id is not present" do
    before { @order.delivery_address_id = " "}
    it { should_not be_valid }
  end

  describe "when user_id is not present" do
    before { @order.user_id = " "}
    it { should_not be_valid }
  end

end
