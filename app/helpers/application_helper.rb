module ApplicationHelper
  def modal_link_to(text, url, options = {})
    options[:class] = options[:rev] = 'modal'
    link_to text, url, options
  end
end
