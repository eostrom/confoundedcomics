# Capybara will automatically wait for form elements to be added to
# the page, but in Selenium it errors out, because the elements aren't
# yet visible while the popup animates into existence. So this step
# waits for the popup content to be present *and visible*.
When /^I wait for the popup$/ do
  begin
    wait_until { page.find('#nyroModalContent').try(:visible?) }
  rescue Capybara::ElementNotFound
    # For now, we assume this means we're using a driver that doesn't
    # support JavaScript, so the popup is never created. We also
    # assume that the application supports users without JavaScript,
    # so they'll be filling out the form on a new page instead of in a
    # popup.
  end
end

When /^I wait for the popup to close$/ do
  begin
    wait_until { !page.find('#nyroModalContent').try(:visible?) }
  rescue Capybara::ElementNotFound
    # See above.
  end
end

Then /^the page should be ([^ ]+)$/ do |state|
  assert page.has_css?(".#{state}.content")
end

Then /^the "(.*)" link should be unpublished$/ do |text|
  assert page.find('.unpublished a', :text => text)
end
