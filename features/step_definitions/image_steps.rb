Then /^I should see the (.*) style (.*) for (.*) "(.*)"( within "(.*)")?$/ do |style, attachment, klass, title, within, selector|
  path = klass.capitalize.constantize.find_by_title(title).
    send(attachment).url(style.to_sym)
  within(selector || 'html') do
    assert page.has_css?("img[src='#{path}']")
  end
end
