require 'spec_helper'

describe OrderItem do
  before do
    @address = FactoryGirl.build(:address)
    @user = FactoryGirl.create(:user)
    @address.user = @user
    @address.save
    @order = @user.orders.new
    @order.address_id = @address.id
    @order.save
    @item = FactoryGirl.create(:item)
    @order_item = @order.add_item(@item.id)
  end

  subject { @order_item }

  it { should be_valid }

  describe "when order_id is not present" do
    before { @order_item.order_id = " "}
    it { should_not be_valid }
  end

  describe "when item_id is not present" do
    before { @order_item.item_id = " " }
    it { should_not be_valid }
  end

  describe "when item is added to the order" do
    it "should add a new order_item" do
      expect { @order_item.save }.to change(OrderItem, :count).by(1)
    end

    it "should add a qty of 1" do
      @order_item.save
      @order_item.qty.should == 1 
    end
  end

  describe "when duplicate item is added to the order" do
    before do
      @order_item.save
      @other_order_item = @order.add_item(@item.id) 
    end

    it "should be valid" do
      @other_order_item.should be_valid
    end

    it "should not create a new order_item" do
      expect { @other_order_item.save }.to_not change(OrderItem, :count).by(1)
    end

    it "should increment the item qty" do
      @other_order_item.save
      @other_order_item.qty.should == 2 
    end
  end
end
