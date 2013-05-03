Given /^they have added an item to the basket$/ do 
  @item = FactoryGirl.create(:item)
  visit item_path @item
  click_button "Add to Basket"
end

And /^the user visits the basket page$/ do
  visit basket_items_path
end

When /^they click the checkout button$/ do
  click_button "Checkout"
end

Then /^they should see the delivery address page$/ do
  page.should have_selector('h2', text: 'Delivery Address')
end

When /^they add a new delivery address$/ do
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

And /^they click Continue$/ do
  click_button "Continue"
end

Then /^they should see the payment page$/ do
  page.should have_selector('h2', text: 'Order Details')
end

When /^they add valid payment information$/ do 
  fill_in "Card number", with: "4111111111111111"
  select "Visa", :from => "payment[card_type]"
  select "2014", :from => "payment[expiry_date(1i)]"
  select "4 - April", :from => "payment[expiry_date(2i)]"
  fill_in "CVS", with: '111'
end

And /^they use an existing billing address$/ do
  choose 'payment_existing_address_existing'
end

And /^they click process payment$/ do
  click_button "Process Payment"
end

Then /^they should see the order confirmation page$/ do
  page.should have_selector('h2', text: 'Thank you for your order')
end
