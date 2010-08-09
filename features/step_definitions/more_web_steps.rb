Then /^the page title should be "(.*)"$/ do |title|
  Then %{I should see "#{title}" within "title"}
end
