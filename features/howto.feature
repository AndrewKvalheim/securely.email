Feature: 'How to email' pages

  Scenario: Show a page with information from the key
    Given a typical identity
    When I go to its contact page
    Then I should see information from its key
