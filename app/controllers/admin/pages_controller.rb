class Admin::PagesController < ApplicationController

  hobo_model_controller Page

  auto_actions :all

end
