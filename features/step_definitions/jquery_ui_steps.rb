# This is kind of a dumb step that can only pick dates in the current
# month, because I didn't want to figure out how to navigate to an
# arbitrary date.
When /^I open the calendar for "(.*)" and click "(.*)"$/ do |locator, date|
  msg = "cannot find date field with id, name, or label '#{locator}'"
  field = find(:xpath, XPath::HTML.fillable_field(locator), :message => msg)
  click = "$('##{field[:id]}').next('.ui-datepicker-trigger').click();"
  page.execute_script(click)

  wait_until { page.find('#ui-datepicker-div').try(:visible?) }
  with_scope('#ui-datepicker-div') { click_link(date) }
end
