Feature: Editing comics
  In order to share her work with the world
  A comics author
  wants to upload and edit comics

  Scenario: Log in
    Given the following users exist:
        | Email Address     | Password |
        | admin@example.com | Admin    |
     When I go to the login page
# TODO: semantic form
      And I fill in "login" with "admin@example.com"
      And I fill in "password" with "Admin"
      And I press "Log in"
     Then I should be on the home page
# TODO: And I should see "Account"
