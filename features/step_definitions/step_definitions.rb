Given(/^the following input$/) do |input|
  @parser = TagParser.new input
end

When(/^I request the value of "(.*?)"$/) do |tag_name|
  @tag_value = @parser.value_for tag_name
end

Then(/^I should receive "(.*?)"$/) do |arg1|
  @tag_value.should eq "we have spaces"
end
