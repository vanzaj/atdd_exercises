require "rspec"
require "wrong"
require_relative "../../person"

include Wrong

When(/^create a person \"(.*)\", \"(.*)\"$/) do |name, title|
  visit 'http://localhost:4567/create'
  fill_in 'name', :with => name
  fill_in 'title', :with => title
  click_button 'Create'
end

Then(/^succeed$/) do
  expect(page).to have_content("created!")
end

Then(/^see \"(.*?)\"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^the person \"(.*)\", \"(.*)\" exists$/) do |name, title|
  visit 'http://localhost:4567/people'
  within_table('people') do
    expect(first('tr', :text => name)).to have_content(title)
  end
end

Given(/^delete all people$/) do
  visit 'http://localhost:4567/people'
  click_button 'Delete All!'
  eventually { expect(Person.count).to eq(0) }
end
