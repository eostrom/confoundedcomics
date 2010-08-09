module PagesHelper
  def previous_page_link(page)
    link_to 'Previous', page.previous unless page.previous.nil?
  end

  def next_page_link(page)
    link_to 'Next', page.next unless page.next.nil?
  end
end
