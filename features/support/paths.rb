module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the book "(.*)"/
      book = find_for_path(Book, :title => $1)
      book_page_path(book, book.pages.latest)
    when /the page "(.*)"/
      page = find_for_path(Page, :title => $1)
      book_page_path(page.book, page)
    when /(page )?"(.*)" (of|from) "(.*)"/
      path_to_book_page($4, $2)
    when /an untitled page of "(.*)"/
      path_to_book_page($1, '')

    when /the signin page/
      new_administrator_session_path

    when /the new page page for "(.*)"/
      new_book_page_path(find_for_path(Book, :title => $1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end

  def path_to_book_page(book, page)
    book = find_for_path(Book, :title => book)
    page = find_for_path(book.pages, :title => page)
    if !page
      page = Page.find_by_title(page)
      fail %{Page "#{page}" not found in book "#{book}"} +
        (%{ (found in book "#{page.book.title}")} if page)
    end

    book_page_path(book, page)
  end

  def find_for_path(scope, conditions)
    scope.where(conditions).first ||
      raise("Can't find #{conditions.inspect} in #{scope}")
  end
end

World(NavigationHelpers)
