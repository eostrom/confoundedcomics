When /^I attach the local file "(.*)" to (.*)$/ do |path, field|
  # Note: "field" may include a "within" selector.
  path = File.expand_path(File.join('../files', path), File.dirname(__FILE__))
  When %{I attach the file "#{path}" to #{field}}
end

Then /^the page title should be "(.*)"$/ do |title|
  Then %{I should see "#{title}" within "title"}
end

Then /^"(.*)" should not be a link$/ do |content|
  # assert !all('a[href]').any? { |a| puts a.inspect; content == a.content }
  assert page.has_no_xpath?("//a[href][.='#{content}']")
end
