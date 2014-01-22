When(/^I visit "(.*?)"$/) do |path|
  visit path
end

Then(/^I should see "(.*?)"$/) do |words|
  page.body.should include words
end