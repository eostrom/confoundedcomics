Then /^the page should be unpublished$/ do
  assert page.has_css?('.unpublished.content')
end
