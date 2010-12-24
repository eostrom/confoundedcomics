module Publishable
  def published?
    published_at && published_at.to_time < Time.zone.now
  end

  def self.included(mod)
    mod.class_eval do
      scope :published, lambda {
        where('published_at <= ?', Time.zone.now)
      }
    end
  end
end
