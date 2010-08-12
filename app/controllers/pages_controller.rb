class PagesController < ApplicationController
  hobo_model_controller
  # Disable Hobo so I can use my Rails skillz.
  auto_actions

  def show
    @page = Page.last
    render :show
  end
end
