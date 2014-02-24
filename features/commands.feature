Feature: Command interface

  Scenario: Handle a missing command
    When I send no command
    Then I should receive 'Unknown command: ""'

  Scenario: Handle a missing signature
    When I send a command with no signature
    Then I should receive 'No signed command received.'

  Scenario: Require a valid signature
    When I send a command with an invalid signature
    Then I should receive 'Invalid signature.'

  Scenario: Handle an unknown command
    When I send the command 'xxxxxxxx'
    Then I should receive 'Unknown command: "xxxxxxxx"'

  Scenario: Enable an alias
    When I send the command 'enable' to 'TestAlias'
    Then I should receive 'Enabled alias: TestAlias'

  Scenario: Cannot enable an alias that is already enabled
    Given the alias 'TestAlias' is enabled
    When I send the command 'enable' to 'TestAlias'
    Then I should receive 'Already enabled.'

  Scenario: Cannot enable more than one alias
    Given the alias 'TestAlias' is enabled
    When I send the command 'enable' to 'OtherTestAlias'
    Then I should receive 'You may only enable one alias.'

  Scenario: Disable an alias
    Given the alias 'TestAlias' is enabled
    When I send the command 'disable' to 'TestAlias'
    Then I should receive 'Disabled alias: TestAlias'

  Scenario: Cannot disable an alias that is not enabled
    When I send the command 'disable' to 'TestAlias'
    Then I should receive 'Not enabled.'

  Scenario: Cannot disable someone else's alias
    Given the alias 'TestAlias' is enabled by someone else
    When I send the command 'disable' to 'TestAlias'
    Then I should receive 'Permission denied.'
