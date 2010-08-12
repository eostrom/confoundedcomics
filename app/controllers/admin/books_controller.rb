class Admin::BooksController < ApplicationController

  hobo_model_controller Book

  auto_actions :all

end
