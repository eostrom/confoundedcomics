module PagesHelper
  def banner_link(book)
    if book.banner?
      link_to(image_tag(book.banner.url, :alt => book.title),
        [book, book.pages.visible_to(current_administrator).latest])
    end
  end

  def maybe_link(name, page)
    klass = name.downcase

    if page
      link_to(name, page, :class => klass, :title => name)
    else
      content_tag(:a, name, :class => klass, :title => name)
    end
  end

  def nav_list_item(label, direction)
    page = @page.send(direction, @pages)

    content_tag('li',
      maybe_link(label, [@book, page]),
      :class => page && published_state(page))
  end

  def page_form_for(page)
    semantic_form_for([page.book, page],
      :html => {:class => 'admin', :multipart => true}) do |form|
      yield form
    end
  end

  def published_state(page)
    page.published? ? :published : :unpublished
  end
end
