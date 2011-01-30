# Creating a new BookLink requires three things:
#
#   * Update the library image (public/images/library.jpg).
#   * Create the Scam model, below.
#   * Add the link coordinates to _library.sass.
#
# The ID of the HTML anchor will be based on the book title,
# permalink-style.

class BookLink
  include Scam

  attr_accessor :title, :url

  def title=(value)
    @identifier = Babosa::Identifier.new(value)
    @title = value
  end

  def to_param
    @as_param ||= @identifier.normalize!
  end
end

BookLink.create(
  :title => "San Jose: I'll Keep You",
  :url => 'http://www.smackjeeves.com/comicprofile.php?id=73148')
BookLink.create(
  :title => "Shark Book",
  :url => 'http://www.flickr.com/photos/confoundedcontraption/3457965863/')
