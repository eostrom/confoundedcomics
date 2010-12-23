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
      page_path(find_for_path(Book, :title => $1).pages.latest)
    when /the page "(.*)"/
      page_path(find_for_path(Page, :title => $1))
    when /(page )?"(.*)" (of|from) "(.*)"/
      book = find_for_path(Book, :title => $4)
      page = find_for_path(book.pages, :title => $2)
      if !page
        page = Page.find_by_title($2)
        fail %{Page "#{$2}" not found in book "#{$4}"} +
          (%{ (found in book "#{page.book.title}")} if page)
      end

      page_path(page)

    when /the login page/
      new_administrator_session_path

    when /the new page page/
      new_page_path

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

  def find_for_path(scope, conditions)
    scope.where(conditions).first ||
      raise("Can't find #{conditions.inspect} in #{scope}")
  end
end

World(NavigationHelpers)
