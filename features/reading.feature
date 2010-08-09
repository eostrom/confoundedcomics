Feature: Reading comics!
  In order to better understand the world
  A comics fan
  wants to read comics

  Scenario: Browse sequentially
    Given the following pages exist:
        | Title  | Commentary       | Published At | Book          |
        | Page 1 | The first page.  |   2010-08-01 | Title: Book 1 |
        | Page 3 | The third page.  |   2010-08-03 | Title: Book 1 |
        | Page 2 | The second page. |   2010-08-02 | Title: Book 1 |
     When I go to the home page
     Then I should see "The third page."
      And I should not see "Next"
     When I follow "Previous"
     Then I should be on the page "Page 2"

     When I follow "Previous"
     Then I should be on the page "Page 1"
      And I should not see "Previous."

     When I follow "Next"
     Then I should be on the page "Page 2"
