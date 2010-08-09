class Page < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title        :string
    commentary   :text
    published_at :date
    timestamps
  end

  belongs_to :book
  validates_presence_of :book, :title

  named_scope :before, lambda { |finish|
    finish = finish.published_at if Page === finish
    { :conditions => ['published_at < ?', finish] }
  }

  named_scope :after, lambda { |start|
    start = start.published_at if Page === start
    { :conditions => ['published_at > ?', start] }
  }

  def first_predecessor
    # TODO: book.pages
    Page.published.before(self).find(:first, :order => 'published_at ASC')
  end

  def previous
    return nil if !published_at

    # TODO: book.pages
    Page.published.before(self).find(:first, :order => 'published_at DESC')
  end

  def next
    return nil if !published_at || published_at.beginning_of_day > Time.zone.now

    # TODO: book.pages
    Page.published.after(self).find(:first, :order => 'published_at ASC')
  end

  def last_successor
    # TODO: book.pages
    Page.published.after(self).find(:first, :order => 'published_at DESC')
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
    true
  end

end
