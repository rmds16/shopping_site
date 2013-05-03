Given /^a user visits the items index page$/ do
  visit items_path
end

When /^they visit an items page$/ do
  @item = FactoryGirl.create(:item)
  visit item_path(@item)
end

Then /^they should see the item page$/ do
  page.should have_selector('h2', title: @item.name)
end

And /^they should see the add to basket link$/ do
  page.should have_button("Add to Basket")
end

When /^they click on the add to basket link$/ do
  click_button "Add to Basket"
end

Then /^they should see the basket page$/ do
  page.should have_selector('h2', text: 'Basket')  
end

And /^the basket should include the item$/ do
  page.should have_selector('td', text: @item.name)
  page.should have_selector('td', text: '1')
  page.should have_selector('td', text: @item.price.to_s)
end

And /^the basket page should have the checkout button$/ do
  page.should have_button("Checkout")
end
