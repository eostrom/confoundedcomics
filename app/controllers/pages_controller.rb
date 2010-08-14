class PagesController < ApplicationController
  hobo_model_controller
  # Disable Hobo so I can use my Rails skillz.
  auto_actions

  def show
    @page = (params[:id] ?
      Page.published.find(params[:id], :scope => params[:scope]) :
      Page.latest)
    @book = @page.book

    render :show
  end
end
