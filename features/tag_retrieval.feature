Feature: Access to individual tag values
  In order to get data from messages
  The calling program
  Should be able to retrieve data by tag name

  Scenario: Retrieving a single tag's value by tag name
    Given the following input 
    """
    do=command data.1=10 data.2="we have spaces" mytag data.3="and \nnewlines!" random=stuff data.4="value with \"escaped quotes\"" all_alone
    """
    When I request the value of "data.2"
    Then I should receive "we have spaces"

  Scenario: Retrieving a list of tags under a given path
    Given the following input
    """
    item.name=list item.1.name=subitem1 item.1.value=1024 item.2.name=subitem2 item.2.value=42
    """
    When I request the tags at the path "item.1."
    Then I should receive:
      |name  | value    |
      |name  | subitem1 |
      |value | 1024     |
