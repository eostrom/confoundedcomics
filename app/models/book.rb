class Book < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title       :string
    description :text
    published_at :date
    timestamps
  end

  has_many :pages, :order => "pages.published_at ASC"
  validates_presence_of :title

  has_attached_file :banner

  has_friendly_id :title, :use_slug => true

  def style
    title.downcase.gsub(/\s+/, '_')
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
