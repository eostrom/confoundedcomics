class Book < ActiveRecord::Base

  include HoboFields

  fields do
    title       :string
    description :text
    published_at :date
    timestamps
  end

  has_many :pages
  validates_presence_of :title

  has_attached_file :banner

  has_friendly_id :title, :use_slug => true

  def style
    title.downcase.gsub(/\s+/, '_')
  end

  scope :published, lambda {
    where('published_at <= ?', Time.zone.now)
  }

  scope :descend_by_published_at, order('published_at DESC')

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
