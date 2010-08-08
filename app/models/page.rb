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

  has_attached_file :comic

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
