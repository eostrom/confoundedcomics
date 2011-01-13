module Publishable
  def published?
    published_at && published_at.to_time < Time.zone.now
  end

  def visible_to(user); user || published?; end

  def published_at=(value)
    super(value.try(:to_date))
  end

  def published_at_string
    @published_at_string ||= published_at.to_s
  end

  def published_at_string=(value)
    self.published_at = value && Chronic.parse(value)
    @published_at_string = value
  end

  def self.included(mod)
    mod.class_eval do
      validate :published_at_string_must_be_parsable
      def published_at_string_must_be_parsable
        errors.add(:published_at_string, "must be a date.") if
          published_at_string.present? && published_at.blank?
      end

      scope :published, lambda {
        where('published_at <= ?', Time.zone.now)
      }

      scope :visible_to, lambda { |user|
        (Administrator === user ?
          where({}) :
          published)
      }

      scope :descend_by_published_at, order('published_at DESC')
    end
  end
end
