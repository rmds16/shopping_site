require 'spec_helper'

describe "Item Pages" do

  subject { page }

  before(:all) { 60.times { FactoryGirl.create(:item) } }
  before { visit items_path }

  describe "All Items Page" do
    it { should have_selector('h1', text: 'All Items') }
    it { should have_selector('title', text: 'All Items') }

    describe "pagination" do

      it { should have_selector('div.pagination') }

      it "should list each item" do
        Item.paginate(page: 1).each do |item|
          page.should have_selector('li', text: item.name)
          page.should have_link(item.name, href: item_path(item))
          page.should have_button("More Details...")
        end
      end
    end
  end

  describe "Item page" do
    let(:item) { FactoryGirl.create(:item) }
    before { visit item_path(item) }

    it { should have_selector('h1', text: item.name) }
    it { should have_selector('title', text: item.name) }
    it { should have_selector('span', text: item.description) }
    it { should have_selector('span', text: sprintf("%.02f", item.price).to_s()) }
    it { should have_button("Add to Basket") }

    it "should add to basket" do
      expect { click_button "Add to Basket" }.to change(BasketItem, :count).by(1)
    end
  end

end
