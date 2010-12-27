class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :optional_layout

  protected

  def optional_layout
    request.xhr? ? false : 'application'
  end
end
