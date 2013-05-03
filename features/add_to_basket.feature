Feature: add to basket

Scenario: Successfully add an item to the basket
  Given a user visits the items index page
  When they visit an items page
  Then they should see the item page
  And they should see the add to basket link
  When they click on the add to basket link
  Then they should see the basket page
  And the basket should include the item
  And the basket page should have the checkout button
