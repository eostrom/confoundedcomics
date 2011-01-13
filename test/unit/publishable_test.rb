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

    should 'accept natural-language publish dates' do
      Timecop.freeze do
        @publishable.published_at_string = 'today'
        assert_equal Date.today, @publishable.published_at
      end
    end

    context 'with a malformed date string' do
      setup { @publishable.published_at_string = 'asdaeae33' }

      should 'be invalid' do
        assert !@publishable.valid?
        assert @publishable.errors[:published_at_string]
      end
    end
  end

  context 'A published Publishable' do
    setup do
      @publishable = Factory.create(:publishable,
        :published_at => 1.day.ago)
    end

    should 'be visible to everyone' do
      admin = Factory.create(:administrator)
      assert @publishable.visible_to(admin)
      assert PublishableTestable.visible_to(admin).find(@publishable)
      assert @publishable.visible_to(nil)
      assert PublishableTestable.visible_to(nil).include? @publishable
    end
  end

  context 'An unpublished Publishable' do
    setup do
      @publishable = Factory.create(:publishable,
        :published_at => 1.day.from_now)
    end

    should 'be visible only to administrators' do
      admin = Factory.create(:administrator)
      assert @publishable.visible_to(admin)
      assert PublishableTestable.visible_to(admin).find(@publishable)
      assert !@publishable.visible_to(nil)
      assert !(PublishableTestable.visible_to(nil).include? @publishable)
    end
  end
end
