module Publishable
  def published?
    published_at && published_at.to_time < Time.zone.now
  end

  def visible_to(user); user || published?; end

  def self.included(mod)
    mod.class_eval do
      scope :published, lambda {
        where('published_at <= ?', Time.zone.now)
      }

      scope :visible_to, lambda { |user|
        (Administrator === user ?
          where({}) :
          published)
      }
    end
  end
end
