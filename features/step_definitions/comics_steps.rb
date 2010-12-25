Then /^the page should be ([^ ]+)$/ do |state|
  assert page.has_css?(".#{state}.content")
end
