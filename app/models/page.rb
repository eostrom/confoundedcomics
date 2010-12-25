class Page < ActiveRecord::Base

  include HoboFields

  fields do
    title        :string
    commentary   :text
    published_at :date
    timestamps
  end

  include Publishable

  has_attached_file :comic
  validates_attachment_presence :comic

  belongs_to :book
  validates_presence_of :book

  default_scope :order => 'published_at ASC'

  has_friendly_id :date_title, :scope => :book, :use_slug => true
  def date_title
    [
      published_at,
      (title.present? ?
        FriendlyId::SlugString.new(title).normalize! :
        "page-#{number}")
    ].compact.join('-')
  end
  def normalize_friendly_id(text); text; end

  def number
    book.pages.before(self).count + 1
  end

  def to_s
    title.presence || '[untitled]'
  end

  def published_at=(time)
    self[:published_at] = time && time.to_date
  end

  scope :before, lambda { |finish|
    finish = finish.published_at if Page === finish
    where('published_at < ?', finish)
  }

  scope :after, lambda { |start|
    start = start.published_at if Page === start
    where('published_at > ?', start)
  }

  def first_predecessor(scope = book.pages.published)
    scope.before(self).first
  end

  def previous(scope = book.pages.published)
    return nil if !published_at

    scope.before(self).last
  end

  def next(scope = book.pages.published)
    scope.after(self).first
  end

  def last_successor(scope = book.pages.published)
    scope.after(self).last
  end

  def self.latest
    last
  end

  def published?
    super && book.published?
  end
end
