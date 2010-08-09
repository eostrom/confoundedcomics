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

  def previous
    return nil if !published_at

    Page.published.find(:first,
      :order => 'published_at DESC',
      :conditions => ['id <> ? AND published_at < ?',
        id, [published_at, Time.zone.now].min])
  end

  def next
    return nil if !published_at || published_at.beginning_of_day > Time.zone.now

    Page.find(:first,
      :order => 'published_at ASC',
      :conditions => ['id <> ? AND published_at BETWEEN ? AND ?',
        id, published_at, Time.zone.now])
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
