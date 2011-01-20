class Book < ActiveRecord::Base

  include HoboFields

  fields do
    title       :string
    description :text
    published_at :date
    timestamps
  end

  include Publishable

  has_many :pages
  validates_presence_of :title

  has_attached_file :banner

  has_friendly_id :title, :use_slug => true

  def style
    title && title.downcase.gsub(/\s+/, '_')
  end

  scope :friendly_id_eq, lambda { |param|
    name, sequence = param.parse_friendly_id
    includes(:slugs).where(:slugs => {:name => name, :sequence => sequence})
  }
end
