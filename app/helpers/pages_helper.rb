module PagesHelper
  def banner_link(book)
    if book.banner?
      link_to(image_tag(book.banner.url, :alt => book.title),
        book.pages.latest)
    end
  end

  def maybe_link(name, url)
    klass = name.downcase

    if url
      link_to(name, url, :class => klass, :title => name)
    else
      content_tag(:a, name, :class => klass, :title => name)
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
