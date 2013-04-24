require 'spec_helper'

describe "BasketItems" do

  subject { page }
  
  describe "empty basket" do
    before do
      visit basket_items_path
    end

    it { should_not have_button('Checkout') }
  end

  describe "after adding an item to the basket" do
    before do 
      @basket = Basket.create
      @item = FactoryGirl.create(:item)
      @basket_item = @basket.add_item(@item.id)
    end

    it "should add a new basket_item" do
      expect { @basket_item.save }.to change(BasketItem, :count).by(1)
    end
#    it { should have_selector('td', @item.name) }
#    it { should have_selector('td', @basket_item.qty) }
#    it { should have_selector('td', @item.price) }
    before do
      visit basket_items_path
    end

    it { should have_button('Checkout') }
  end

end
