module PagesHelper
  def maybe_link(name, url, *args)
    if url
      link_to(name, url, *args)
    else
      content_tag(:a, name, *args)
    end
  end

  def first_page_link(page)
    maybe_link 'First', page.first_predecessor
  end

  def previous_page_link(page)
    maybe_link 'Previous', page.previous
  end

  def next_page_link(page)
    maybe_link 'Next', page.next
  end

  def last_page_link(page)
    maybe_link 'Last', page.last_successor
  end
end
