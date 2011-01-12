class PublishableTestable < ActiveRecord::Base
  set_table_name 'pages'
  include Publishable
end

Factory.define(:publishable, :class => PublishableTestable) { |publishable| }

Factory.define(:book) do |book|
  book.title 'A Book'
end

Factory.define(:published_book, :parent => :book) do |book|
  book.published_at Date.today
end

Factory.define(:page) do |page|
  page.association :book, :factory => :book
  page.comic_file_name 'AComic.jpg'
end
