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
      And I fill in "Publish date" with "today"
      And I press "Save"
     Then I should be on the page "Page 1"
      And the page should be published

     When I follow "New page"
      And I follow "Cancel"
     Then I should be on the page "Page 1"

     When I follow "New page"
      And I fill in the following:
        | Title        | Page 2                      |
        | Publish date | 2037-01-01                  |
      And I attach the local file "pictures/comic.jpg" to "Comic"
      And I press "Save"

# TODO:
#      And I press "Save and add another"
#     Then I should be on the new page page

      And I follow "Page 1"
     Then the "Next" link should be unpublished
      And the "Last" link should be unpublished

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

  @javascript
  Scenario: Add a page
    Given the following pages exist:
        | Title  | Book          |
        | Page 1 | Title: Book 1 |
      And I am signed in
      And I am on the page "Page 1"

     When I follow "New page"
      And I wait for the popup
      And I attach the local file "pictures/comic.jpg" to "Comic"
      And I press "Save"
     Then I should be on an untitled page of "Book 1"

  @javascript
  Scenario: Set a publish date using a date picker
    Given a published book exists with a title of "Book 1"
      And the following pages exist:
        | Title  | Book          |
        | Page 1 | Title: Book 1 |
      And I am signed in
      And I am on the page "Page 1"

     When I follow "New page"
      And I wait for the popup
      And I attach the local file "pictures/comic.jpg" to "Comic"
      And I open the calendar for "Publish date" and click "1"
      And I press "Save"
     Then I should be on an untitled page of "Book 1"
        # The first of the current month is never in the future, so...
      And the page should be published

  @javascript
  Scenario: Cancel adding a page
    Given the following pages exist:
        | Title  |
        | Page 1 |
        | Page 2 |
      And I am signed in
      And I am on the page "Page 1"

     When I follow "New page"
      And I wait for the popup
      And I follow "Cancel"
     Then I should be on the page "Page 1"
      And I should not see "Publish date"

  @javascript
  Scenario: Edit a page
    Given a published book exists with a title of "Book 1"
      And the following pages exist:
        | Title  | Book          |
        | Page 1 | Title: Book 1 |
        | Page 2 | Title: Book 1 |
      And I am signed in
      And I am on the page "Page 1"

     When I follow "Edit page"
      And I wait for the popup
      And I fill in "Title" with "Page the First"
      And I fill in "Publish date" with "2010-08-01"
      And I press "Save"
     Then I should be on the page "Page the First"
      And the page should be published
