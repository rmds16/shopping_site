require 'spec_helper'

describe "Order Page" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }
  before do
    @basket = Basket.create
    @item = FactoryGirl.create(:item)
    @basket_item = @basket.add_item(@item.id)
    visit signin_path
    sign_in user
  end

  describe "new order" do

    let(:submit) { "Continue" }

    describe "with no stored addresses" do
      before { visit new_order_path }

      it { should_not have_field "order_existing_address_existing" }
      it { should_not have_field "order_existing_address_new" }
      it { should_not have_field "order_delivery_address_id" }

      describe "fill in address" do
        before do
          fill_in "First name", with: "Example"
          fill_in "Last name", with: "User"
          fill_in "Organisation", with: "Test"
          fill_in "Building", with: "111"
          fill_in "Street", with: "Example Street"
          fill_in "Town", with: "London"
          fill_in "County", with: "London"
          fill_in "Post code", with: "AA1 1ZZ"
          fill_in "Country", with: "UK"
        end

        describe "should create an order with a new address" do
          subject { ->  { click_button submit } }
          it { should change(Address, :count).by(2) }
          it { should change(Order, :count).by(1) }
        end
      end
    end

    describe "with stored addresses" do
      before do
        @address = FactoryGirl.build(:book_address)
        @address.user = user
        @address.save
        visit new_order_path
      end

      it { should have_field "order_delivery_address_id" }
      it { should have_selector "option", :id => '1' }
      it { should have_field "order_existing_address_new" }
      it { should have_field "order_existing_address_existing" }

      it "should create an order" do
         expect { click_button submit }.to change(Order, :count).by(1)
      end
    end
  end
end
