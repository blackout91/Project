Feature: CHECK_ADMIN_PAGES

    Scenario: Check homepage of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      Then I should see "Welcome admin_first!"
      
    Scenario: Check tweet page of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      When I go to the tweet page of admin
      When I choose "city_sheffield"
      When I press "set city"
      Then I should be on the filterByCity page
      Then I should see "Tweets from sheffield users"
      When I choose "filterByCity_Leeds"
      When I press "set city"
      Then I should see "Tweets from leeds users"
      Then I should see "ID"
      Then I should see "User"
      Then I should see "Text"
      Then I should see "Reply Message"

    Scenario: Check order page of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      When I go to the order page of admin
      Then I should see "Welcome Order!"

    Scenario: Check change offers page of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      When I go to the change offers page of admin
      Then I should see "Change Offer!"
      Then I should see "This page is for seting an offer for user."
      Then I should see "First Name"
      Then I should see "Last Name"
      Then I should see "Twitter"
      Then I should see "City"
      Then I should see "Offers"
      Then I should see "Update"
      
    Scenario: Check change menu page of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      When I go to the change menu page of admin
      Then I should see "Add and change menu items!"
      Then I should see "Item"
      Then I should see "Size"
      Then I should see "Price"
      When I fill in "item" with "Kung Pao Chicken"
      When I select "Large" from "size"
      When I fill in "price" with "8.99"
      When I press "Submit"
      Then I should be on the change menu page of admin
      Then I should see "Kung Pao Chicken"
      Then I should see "Large"
      Then I should see "8.99" 
      
    Scenario: Check change customer page of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      When I go to the change customer page of admin
      Then I should see "Change details"
      Then I should see "First Name"
      Then I should see "Last Name"
      Then I should see "Address"
      Then I should see "Contact"
      Then I should see "Twitter"
      Then I should see "Permissions"
      When I choose "ALL_CUSTOMER_FILTER" 
      When I press "filter"
      Then I should see "Change all details"
      When I choose "CHANGE_CLIENT_USER"
      When I press "filter"
      Then I should see "Change user details"
      When I choose "CHANGE_CLIENT_EMPLOYEE"
      When I press "filter"
      Then I should see "Change employee details"
      When I choose "CHANGE_CLIENT_ADMIN"
      When I press "filter"
      Then I should see "Change admin details"

    Scenario: Check analytics page of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      When I go to the analytics page of admin
      Then I should see "Analytics!"
      
    Scenario: Check history of order page of admin
      Given I am on the signin page
      When I fill in "user" with "admin"
      When I fill in "password" with "nimda"
      When I press "Sign In"
      When I go to the history of order page of admin
      Then I should see "History of Orders!"