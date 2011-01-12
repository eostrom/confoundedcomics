require File.dirname(__FILE__) + '/../test_helper'

class PublishableTest < ActiveSupport::TestCase
  context 'Publishable' do
    context '.published.descend_by_published_at' do
      setup do
        @published = Factory.create(:publishable, :published_at => 2.days.ago)
        @unpublished = Factory.create(:publishable, :published_at => 2.days.from_now)
        @unscheduled = Factory.create(:publishable, :published_at => nil)

        @result = PublishableTestable.published.descend_by_published_at.to_a
      end

      should 'include published items' do
        assert @result.include?(@published)
      end

      should 'not include items to be published' do
        assert !@result.include?(@unpublished)
      end

      should 'not include unscheduled items' do
        assert !@result.include?(@unscheduled)
      end
    end
  end

  context 'A Publishable' do
    setup do
      @publishable = Factory.build(:publishable)
    end

    should('be valid') { assert @publishable.valid? }

    context 'with a malformed date string' do
      setup { @publishable.published_at_string = 'asdaeae33' }

      should 'be invalid' do
        assert !@publishable.valid?
        assert @publishable.errors[:published_at_string]
      end
    end
  end
end
