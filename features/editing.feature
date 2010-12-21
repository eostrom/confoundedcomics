Feature: Editing comics
  In order to share her work with the world
  A comics author
  wants to upload and edit comics

  Scenario: Log in
    Given the following administrators exist:
        | Email             | Password |
        | admin@example.com | Admin1   |
     When I go to the login page
      And I fill in "Email" with "admin@example.com"
      And I fill in "Password" with "Admin1"
      And I press "Sign in"
     Then I should be on the home page
      And I should see "Signed in"
