Feature: Signing in

Scenario: Unsuccessful signin
  Given a user visits the signin page
  When they submit invalid signin information
  Then they should see an error message

Scenario: Successful signin
  Given a user visits the signin page
  And the user has an account
  And the user submits valid signin information
  Then they can visit their address book
  And they can see their order history
