class PagesController < ApplicationController
  hobo_model_controller
  # Disable Hobo so I can use my Rails skillz.
  auto_actions

  def show
    @page = params[:id] ? Page.published.find(params[:id]) : Page.latest

    render :show
  end
end
