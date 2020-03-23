Feature: CHECK_USER_PAGES

    Scenario: Check homepage of users
      Given I am on the signin page
      When I fill in "user" with "user"
      When I fill in "password" with "resu"
      When I press "Sign In"
      Then I should be on the user homepage
    
    Scenario: Check menu page of users
      Given I am on the signin page
      When I fill in "user" with "user"
      When I fill in "password" with "resu"
      When I press "Sign In"
      When I go to the menu page of user
      Then I should see "Menu!"
      #Test title of form
      Then I should see "Item"
      Then I should see "Small"
      Then I should see "Medium"
      Then I should see "Large"
      
    Scenario: Check offer page of users
      Given I am on the signin page
      When I fill in "user" with "user"
      When I fill in "password" with "resu"
      When I press "Sign In"
      When I go to the offer page of user
      Then I should see "Special offers availible:"
    
    Scenario: Check details page
      Given I am on the signin page
      When I fill in "user" with "user"
      When I fill in "password" with "resu"
      When I press "Sign In"
      When I go to the details page of user
      Then I should see "Change customer details"
      Then I should see "First Name"
      Then I should see "Last Name"
      Then I should see "Postcode"
      Then I should see "Email"
      Then I should see "Home phone"
      Then I should see "Mobile phone"
      Then I should see "Twitter"
      Then I should see "Password"
      Then I should see "City"
      Then I should see "Permissions"
      #test update details
      
      #test first name
      Then I should see "user_first"
      When I fill in "firstname" with "Arthur"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "Arthur"
      
      #test last name
      Then I should see "user_last"
      When I fill in "lastname" with "Pendragon"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "Pendragon"
      
      #test postcode
      Then I should see "user_post"
      When I fill in "address" with "new_post"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "new_post"
      
      #test email
      Then I should see "user@user.com"
      When I fill in "email" with "new@email.com"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "new@email.com"
      
      #test homephone
      Then I should see "789"
      When I fill in "homephone" with "987"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "987"
      
      #test mobile phone
      Then I should see "321"
      When I fill in "mobphone" with "123"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "123"
      
      #test twitter
      Then I should see "user"
      When I fill in "handle" with "user_new"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "user_new"
      
      #test password
      Then I should see "*****"
      When I fill in "password" with "123"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "*****"
      
      #test city
      Then I should see "leeds"
      When I select "sheffield" from "city"
      Then I press "Update Details"
      Then I should be on the user homepage
      When I go to the details page of user
      Then I should see "sheffield"