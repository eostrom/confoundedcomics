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

  has_friendly_id :date_title, :use_slug => true
  def date_title
    [
      published_at || id || 'page',
      (FriendlyId::SlugString.new(title).normalize! if title.present?)
    ].compact.join('-')
  end
  def normalize_friendly_id(text); text; end

  def to_s
    title.presence || '[untitled]'
  end
  def self.name_attribute; :to_s; end

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

  def first_predecessor
    book.pages.published.before(self).find(:first, :order => 'published_at ASC')
  end

  def previous
    return nil if !published_at

    book.pages.published.before(self).last
  end

  def next
    return nil if !published_at || published_at.beginning_of_day > Time.zone.now

    book.pages.published.after(self).
      find(:first, :order => 'published_at ASC')
  end

  def last_successor
    book.pages.published.after(self).last
  end

  def self.latest
    last
  end

  def published?
    super && book.published?
  end
end
