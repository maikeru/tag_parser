Given(/^the following input$/) do |input|
  @parser = TagParser.new input
end

When(/^I request the value of "(.*?)"$/) do |tag_name|
  @tag_value = @parser.value_for tag_name
end

When(/^I request the tags at the path "(.*?)"$/) do |tag_path|
  @tags_at_path = @parser.tags_at tag_path
end

Then(/^I should receive "(.*?)"$/) do |arg1|
  @tag_value.should eq "we have spaces"
end

Then(/^I should receive:$/) do |table|
  # table is a Cucumber::Ast::Table
  rows_hash = table.rows_hash
  expected = Hash[rows_hash.map { |k, v| [k.to_sym, v] }]
  @tags_at_path.should eq expected
end
