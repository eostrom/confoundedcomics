Feature: Reading comics!
  In order to better understand the world
  A comics fan
  wants to read comics

  Scenario: Read a page
    Given the following books exist:
        | Title  | Banner file name |
        | Book 1 | banner.jpg       |
      And the following pages exist:
        | Title  | Commentary       | Published At | Book          |
        | Page 1 | The first page.  |   2010-08-01 | Title: Book 1 |
     When I go to the page "Page 1"
     Then the page title should be "Book 1 - Confounded Contraption"
      And I should see the original style banner for book "Book 1"
      And I should see "The first page."

     When I follow "Book 1"
     Then I should be on the page "Page 1"

  Scenario: Browse sequentially
    Given the following pages exist:
        | Title  | Commentary       | Published At | Book          |
        | Page 1 | The first page.  |   2010-08-01 | Title: Book 1 |
        | Page 3 | The third page.  |   2010-08-03 | Title: Book 1 |
        | Page 2 | The second page. |   2010-08-02 | Title: Book 1 |
     When I go to the home page
     Then I should see "The third page."
      And "Next" should not be a link
      And "Last" should not be a link
     When I follow "Previous"
     Then I should be on the page "Page 2"

     When I follow "Previous"
     Then I should be on the page "Page 1"
      And "Previous" should not be a link
      And "First" should not be a link

     When I follow "Next"
     Then I should be on the page "Page 2"

     When I follow "First"
     Then I should be on the page "Page 1"

     When I follow "Last"
     Then I should be on the page "Page 3"
