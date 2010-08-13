class Book < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title       :string
    description :text
    published_at :date
    timestamps
  end

  has_many :pages, :order => 'published_at ASC'
  validates_presence_of :title

  has_attached_file :banner

  def style
    title.downcase.gsub(/\s+/, '_')
  end

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
