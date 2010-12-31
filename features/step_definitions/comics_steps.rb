Then /^the page should be ([^ ]+)$/ do |state|
  assert page.has_css?(".#{state}.content")
end

Then /^the "(.*)" link should be unpublished$/ do |text|
  assert page.find('.unpublished a', :text => text)
end
