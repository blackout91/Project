Feature: CHECK_EMPLOYEE_PAGES

    Scenario: Check homepage of employee
      Given I am on the signin page
      When I fill in "user" with "employee"
      When I fill in "password" with "eeyolpme"
      When I press "Sign In"
      Then I should see "Welcome employee_first!"
      
    Scenario: Check tweet page of employee
      Given I am on the signin page
      When I fill in "user" with "employee"
      When I fill in "password" with "eeyolpme"
      When I press "Sign In"
      When I go to the tweet page of employee
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

    Scenario: Check order page of employee
      Given I am on the signin page
      When I fill in "user" with "employee"
      When I fill in "password" with "eeyolpme"
      When I press "Sign In"
      When I go to the order page of employee
      Then I should see "Welcome Order!"

    Scenario: Check change offers page of employee
      Given I am on the signin page
      When I fill in "user" with "employee"
      When I fill in "password" with "eeyolpme"
      When I press "Sign In"
      When I go to the change offers page of employee
      Then I should see "Change Offer!"
      Then I should see "This page is for seting an offer for user."
      Then I should see "First Name"
      Then I should see "Last Name"
      Then I should see "Twitter"
      Then I should see "City"
      Then I should see "Offers"
      Then I should see "Update"