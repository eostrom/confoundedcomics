atom_feed do |feed|
  feed.title("#{h(@book.title)} - Confounded Contraption")
  feed.updated(@updated)

  for page in @pages
    entry_params = {
      :published => page.published_at
    }

    feed.entry(page, entry_params) do |entry|
      entry.title(page.title)
      entry.content(render(:partial => 'pages/body.html', :object => page),
        :type => 'html')

      entry.author do |author|
        author.name("Kate Stewart")
      end
    end
  end
end
