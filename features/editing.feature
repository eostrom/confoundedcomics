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

  Scenario: Create a book
    Given I am logged in

     When I go to the home page
      And I follow "New book"
      And I fill in the book form for "Book 1"
      And I press "Save"
     Then I should be on the new page page for "Book 1" page

     When I fill in the page form for "Page 1"
      And I press "Save"
     Then I should be on the page "Page 1"
      And the page should be unpublished

     When I follow "Edit"
      And I update the published date to today
     Then I should be on the page "Page 1"
      And the page should be published

     When I follow "New page"
      And I fill in the page form for "Page 2"
      And I press "Save and add another"
     Then I should be on the new page page for "Book 1"

     When I follow "Page 1"
     Then I should see "Next" within ".unpublished"
      And I should see "Last" within ".unpublished"

     When I follow "Page 2" within ".unpublished"
     Then I should be on the page "Page 2"
