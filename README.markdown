Confounded Comics
=================

This is the code that runs comics.confoundedcontraptions.com. It has
a simple books/pages model, browsing, and an Atom feed.

Each book can have a different stylesheet. There's no admin UI for
this, it just has to be done in the codebase.

The admin UI for managing books and pages was originally built with
Hobo, while learning Hobo. The Hobo view/controller code is now gone,
but I kept Hobo Fields because I like declared attributes.

Other key tools:

  * Devise (authentication)
  * FriendlyId (URLs)
  * Haml (views)
  * Formtastic (forms)
  * Paperclip (image uploads)
  * Remotipart (image uploads with AJAX)
  * Chronic (natural-language date parsing)

For testing, I use Shoulda, factory_girl, Faker, RR, Timecop,
Cucumber, and Capybara with Selenium.

All this may be out of date - only the Gemfile knows for sure.
