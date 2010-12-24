Feature: Reading comics!
  In order to better understand the world
  A comics fan
  wants to read comics

  Scenario: Read a page
    Given the following books exist:
        | Title  | Banner file name | Published At |
        | Book 1 | banner.jpg       |   2010-08-01 |
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
    Given the following books exist:
        | Title  | Published At |
        | Book 1 |   2010-08-01 |
    Given the following pages exist:
        | Title  | Commentary       | Published At | Book          |
        | Page 1 | The first page.  |   2010-08-01 | Title: Book 1 |
        | Page 3 | The third page.  |   2010-08-03 | Title: Book 1 |
        | Page 2 | The second page. |   2010-08-02 | Title: Book 1 |
     When I go to the book "Book 1"
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

  Scenario: Jump to a page
    Given the following books exist:
        | Title  | Published At |
        | Book 1 |   2010-08-01 |
      And the following pages exist:
        | Title  | Commentary       | Published At | Book          |
        | Page 1 | The first page.  |   2010-08-01 | Title: Book 1 |
        | Page 2 | The second page. |   2010-08-02 | Title: Book 1 |
     When I go to the book "Book 1"
      And I follow "Page 1"
     Then I should be on the page "Page 1"

  Scenario: Browse different books
    Given the following books exist:
        | Title  | Published At |
        | Book 1 |   2010-08-02 |
        | Book 2 |   2010-08-01 |
    Given the following pages exist:
        | Title  | Book          | Published At |
        | Page 2 | Title: Book 1 |   2010-08-02 |
        | Page B | Title: Book 2 |   2010-08-01 |
        | Page 1 | Title: Book 1 |   2010-07-30 |
        | Page A | Title: Book 2 |   2010-07-29 |
     When I go to the home page
      And I follow "Book 2"
     Then I should be on "Page B" of "Book 2"

     When I follow "Previous"
     Then I should be on "Page A" of "Book 2"

     When I follow "Comix"
     Then I should be on the home page
