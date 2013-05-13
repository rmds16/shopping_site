require 'spec_helper'

describe "Payments" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }
  before do
    @basket = Basket.create
    @item = FactoryGirl.create(:item)
    @basket_item = @basket.add_item(@item.id)
    visit signin_path
    sign_in user
    @address = FactoryGirl.build(:address)
    @address.user = user
    @address.save
    visit new_order_path
    click_button "Continue"
  end

  describe "new order payment" do

    before do
      visit new_payment_path
      fill_in "Card number", with: "4111111111111111"
      select "Visa", :from => "payment[card_type]"
      select "2014", :from => "payment[expiry_date(1i)]"
      select "April", :from => "payment[expiry_date(2i)]"
      fill_in "CVS", with: '111'
    end

    it { should have_field "payment_existing_address_existing" }
    it { should have_field "payment_existing_address_new" }
    it { should have_field "payment_address_id" }

    let(:submit) { "Process Payment" }

    describe "with different billing address" do
      before do
        choose('payment_existing_address_new')
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

      subject { ->  { click_button submit } }
      it { should change(Address, :count).by(1) }
      it { should change(Payment, :count).by(1) }
    end

    describe "with stored addresses" do
      before { choose('payment_existing_address_existing') }

      subject { ->  { click_button submit } }
      it { should change(Payment, :count).by(1) }
    end
  end

end
