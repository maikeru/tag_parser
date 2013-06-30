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
