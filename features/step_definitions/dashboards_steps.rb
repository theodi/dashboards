When(/^I visit "(.*?)"$/) do |path|
  visit path
end

Then(/^I should see "(.*?)"$/) do |words|
  page.body.should include words
end

Given(/^the date is is "(.*?)"$/) do |date|
  Timecop.travel(DateTime.parse(date))
end
