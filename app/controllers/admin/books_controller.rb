class Admin::BooksController < Admin::AdminSiteController

  hobo_model_controller Book

  auto_actions :all

end
