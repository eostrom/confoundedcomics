Factory.define(:book) do |book|
  book.title 'A Book'
end

Factory.define(:page) do |page|
  page.association :book, :factory => :book
end
