Feature: Editing comics
  In order to share her work with the world
  A comics author
  wants to upload and edit comics

  Scenario: Sign in
    Given the following administrators exist:
        | Email             | Password |
        | admin@example.com | Admin1   |
     When I go to the signin page
      And I fill in "Email" with "admin@example.com"
      And I fill in "Password" with "Admin1"
      And I press "Sign in"
     Then I should be on the home page
      And I should see "Signed in"
      And I should see "Admin"
     When I follow "Sign out"
     Then I should be on the home page
      And I should not see "Admin"

  @javascript
  Scenario: Create a book
    Given I am signed in

     When I go to the home page
      And I follow "New book"
      And I fill in "Title" with "Book 1"
      And I fill in "Description" with "The first book."
      And I fill in "Publish date" with "2010-08-01"
      And I attach the local file "pictures/banner.jpg" to "Banner"
      And I press "Save"
     Then I should be on the new page page for "Book 1"

     When I fill in "Title" with "Page 1"
      And I fill in "Commentary" with "The first page."
      And I attach the local file "pictures/comic.jpg" to "Comic"
      And I press "Save"
     Then I should be on the page "Page 1"
      And the page should be unpublished

     When I follow "Edit page"
        # TODO: natural date parsing
      And I wait for the popup
      And I fill in "Publish date" with "2010-08-01"
      And I press "Save"
     Then I should be on the page "Page 1"
      And the page should be published

     When I follow "New page"
      And I fill in the following:
        | Title        | Page 2                      |
        | Publish date | 2037-01-01                  |
      And I attach the local file "pictures/comic.jpg" to "Comic"
      And I press "Save"

# TODO:
#      And I press "Save and add another"
#     Then I should be on the new page page

     When I follow "Archive"
      And I follow "Page 1"
     Then the "Next" link should be unpublished
      And the "Last" link should be unpublished

     When I follow "Archive"
     Then the "Page 2" link should be unpublished

     When I follow "Page 2"
     Then I should be on the page "Page 2"

  Scenario: Delete a page
    Given the following pages exist:
        | Title  | Book          |
        | Page 1 | Title: Book 1 |
        | Page 2 | Title: Book 1 |
        | Page 3 | Title: Book 1 |
      And I am signed in

     When I follow "Book 1"
      And I follow "Page 2"
      And I follow "Delete page"
     Then I should be on the page "Page 1"
      And I should not see "Page 2"
