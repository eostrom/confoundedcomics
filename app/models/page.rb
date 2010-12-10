class Page < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title        :string
    commentary   :text
    published_at :date
    timestamps
  end

  belongs_to :book
  validates_presence_of :book

  has_friendly_id :book_date_title, :use_slug => true
  def book_date_title
    [
      book.to_param,
      published_at,
      (FriendlyId::SlugString.new(title).normalize! if title.present?)
    ].compact.join(':')
  end
  def normalize_friendly_id(text); text; end

  def to_s
    title.presence || '[untitled]'
  end
  def self.name_attribute; :to_s; end

  def published_at=(time)
    self[:published_at] = time && time.to_date
  end

  named_scope :before, lambda { |finish|
    finish = finish.published_at if Page === finish
    { :conditions => ['published_at < ?', finish] }
  }

  named_scope :after, lambda { |start|
    start = start.published_at if Page === start
    { :conditions => ['published_at > ?', start] }
  }

  def first_predecessor
    book.pages.published.before(self).find(:first, :order => 'published_at ASC')
  end

  def previous
    return nil if !published_at

    book.pages.published.before(self).
      find(:first, :order => 'published_at DESC')
  end

  def next
    return nil if !published_at || published_at.beginning_of_day > Time.zone.now

    book.pages.published.after(self).
      find(:first, :order => 'published_at ASC')
  end

  def last_successor
    book.pages.published.after(self).find(:first, :order => 'published_at DESC')
  end

  has_attached_file :comic

  def self.latest
    published.find(:first, :order => 'published_at DESC')
  end

  named_scope :published, lambda {
    { :conditions => ['published_at <= ?', Time.zone.now] }
  }

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    acting_user.administrator?
  end

end
