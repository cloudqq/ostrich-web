Feature: Login
As a unauthorized user
I want to fill my login info
So that I can login

   Scenario: User not registered
     Given I am on the login page
     When I fill in "Username" with "cloudqq"
     And I fill in "Password" with "123456"
     And I press "Login"
     Then then login page should be shown again
     And I should see "User not exists"
     And I should not be logined
  

   
		
