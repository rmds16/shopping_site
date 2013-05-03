Feature: Purchase an item

 Scenario: Successfully purchase an item
   Given they have added an item to the basket
   Given a user visits the signin page
   And the user has an account
   When the user submits valid signin information
   And the user visits the basket page
   When they click the checkout button
   Then they should see the delivery address page
   When they add a new delivery address
   And they click Continue
   Then they should see the payment page
   When they add valid payment information
   And they use an existing billing address
   And they click process payment
   Then they should see the order confirmation page 
