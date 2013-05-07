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
      @item = FactoryGirl.create(:item)
      visit item_path @item
    end

    it "should add a new basket_item" do
      expect { click_button "Add to Basket" }.to change(BasketItem, :count).by(1)
    end

    describe "it should show the items in the basket" do
      before do
        click_button "Add to Basket"
        visit basket_items_path
      end

      it { should have_selector('td', text: @item.name) }
      it { should have_selector('td', text: '1') }
      it { should have_selector('td', text: sprintf("%0.2f", @item.price).to_s) }
      it { should have_button('+') }
      it { should have_button('-') }
      it { should have_button('Checkout') }

      describe "click the + button", :js => true do
        before do
          click_button "+"
          wait_until do
            evaluate_script('$.active') == 0
          end
        end

        it { should have_selector('td', text: '2') }

        describe "click the - button" do
          before do
            click_button '-'
            wait_until do
              evaluate_script('$.active') == 0
            end
          end

          it { should have_selector('td', text: '1') }
        end
      end

      describe "click the - button", :js => true do
        before do
          click_button '-'
          wait_until do
            evaluate_script('$.active') == 0
          end
        end

        it { should_not have_selector('td', text: @item.name) }
        it { should_not have_selector('td', text: '1') }
        it { should_not have_selector('td', text: sprintf("%0.2f", @item.price).to_s) }
        it { should_not have_button('+') }
        it { should_not have_button('-') }
        it { should_not have_button('Checkout') }
      end
    end
  end

end
