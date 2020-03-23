Feature: CHECK_BASIC_PAGES

    Scenario: Check homepage
      Given I am on the homepage
      When I press "PREVIOUS_IMAGE_HOMEPAGE"
      When I press "NEXT_IMAGE_HOMEPAGE"
      Then I should be on the homepage
      Then I should see "Welcome to The Pied Piper!"
      Then I should see "Menu"
      
    Scenario: Check aboutUs page
      Given I am on the about us page
      Then I should see "About Us!"
      
    Scenario: Check Menu on the homepage
      Given I am on the homepage
      When I press "HOMEPAGE_SHEF"
      Then I should see "City: Sheffield"
      When I press "HOMEPAGE_LEEDS"
      Then I should see "City: Leeds"
      #Test title of form
      Then I should see "Item"
      Then I should see "Small"
      Then I should see "Medium"
      Then I should see "Large"
      
    Scenario: Check signIn page as user
      Given I am on the signin page
      When I fill in "user" with "user"
      When I fill in "password" with "resu"
      When I press "Sign In"
      Then I should see "Welcome user_first!"
      
    Scenario: Check signIn page as employee
      Given I am on the signin page
      When I fill in "user" with "employee"
      When I fill in "password" with "eeyolpme"
      When I press "Sign In"
      Then I should see "Welcome employee_first!"
      
    Scenario: Check signIn page as admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      Then I should see "Welcome admin_first!"
      
    Scenario: Check signIn page with incorrect way
      Given I am on the signin page
      When I fill in "user" with ""
      When I fill in "password" with ""
      When I press "Sign In"
      Then I should not see "Welcome"
      
    Scenario: Check signUp page as user
      Given I am on the signup page
      When I fill in "user" with "cucumberTesting"
      When I fill in "firstname" with "Arthur"
      When I fill in "lastname" with "Pendragon"
      When I fill in "password" with "cucumber"
      When I fill in "email" with "Avalon@gmail.com"
      When I select "Sheffield" from "city"
      When I press "Sign Up"
      Then I should be on the homepage
      
    Scenario: Check signUp page as user with incorrect way
      Given I am on the signup page
      When I fill in "user" with "cucumberTesting"
      When I fill in "firstname" with "Arthur"
      When I fill in "lastname" with "Pendragon"
      When I fill in "password" with "cucumber"
      When I fill in "email" with "123456"
      When I select "Sheffield" from "city"
      When I press "Sign Up"
      Then I should be on the default signup page
      
    Scenario: Check back to top
      Given I am on the homepage
      When I follow "Back to Top"
      Then I should be on the homepage after back to top
      
    Scenario: Check contact page
      Given I am on the contact us page 
      When I press "reset"
      Then I should be on the contact us page
      Then I should see "Description for the business"
      Then I should see "Or, alternatively, send us an email. Here are our contact details:"
      