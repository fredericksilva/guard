Feature: Guard "init" command

  In order to quickly start a new project with Guard
  As a user
  I want Guard to create a Guardfile template for me

  Scenario: Create an empty Guardfile
    When I run `guard init -b`
    Then the output should match /Writing new Guardfile to .*Guardfile$/
    And the file "Guardfile" should contain "# A sample Guardfile"

  Scenario: Create a Guardfile using a plugin's template
    When I run `guard init rspec`
    Then the output should match /Writing new Guardfile to .*Guardfile$/
    And the file "Guardfile" should match /^guard :rspec, cmd: ['"]bundle exec rspec["'] do$/

  Scenario: Add plugin to when empty Guardfile exists
    Given my Guardfile contains:
    """
    """
    When I run `guard init rspec`
    Then the output should match /rspec guard added to Guardfile, feel free to edit it$/
    And the file "Guardfile" should match /^guard :rspec, cmd: ['"]bundle exec rspec["'] do$/

  Scenario: Add plugin when Guardfile contains only options
    Given my Guardfile contains:
    """
    notification :off
    """
    When I run `guard init rspec`
    Then the output should match /rspec guard added to Guardfile, feel free to edit it$/
    And the file "Guardfile" should match /^guard :rspec, cmd: ['"]bundle exec rspec["'] do$/
