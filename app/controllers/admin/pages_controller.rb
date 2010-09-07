class Admin::PagesController < Admin::AdminSiteController

  hobo_model_controller Page

  auto_actions :all

end
