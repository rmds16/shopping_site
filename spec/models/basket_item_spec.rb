require 'spec_helper'

describe BasketItem do

  before do
    @basket = Basket.create
    @item = FactoryGirl.create(:item)
    @basket_item = @basket.add_item(@item.id)
  end

  subject { @basket_item }

  it { should be_valid }

  describe "when basket_id is not present" do
    before { @basket_item.basket_id = " "}
    it { should_not be_valid }
  end

  describe "when item_id is not present" do
    before { @basket_item.item_id = " " }
    it { should_not be_valid }
  end

  describe "when item is added to the basket" do
    it "should add a new basket_item" do
      expect { @basket_item.save }.to change(BasketItem, :count).by(1)
    end

    it "should add a qty of 1" do
      @basket_item.save
      @basket_item.qty.should == 1 
    end
  end

  describe "when duplicate item is added to the basket" do
    before do
      @basket_item.save
      @other_basket_item = @basket.add_item(@item.id) 
    end

    it "should be valid" do
      @other_basket_item.should be_valid
    end

    it "should not create a new basket_item" do
      expect { @other_basket_item.save }.to_not change(BasketItem, :count).by(1)
    end

    it "should increment the item qty" do
      @other_basket_item.save
      @other_basket_item.qty.should == 2 
    end
  end
end
