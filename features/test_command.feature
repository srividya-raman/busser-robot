Feature: Test command
  In order to run tests written with robot
  As a user of Busser
  I want my tests to run when the robot runner plugin is installed

  Background:
    Given a test BUSSER_ROOT directory named "busser-robot-test"
    When I successfully run `busser plugin install busser-robot --force-postinstall`
    Given a suite directory named "robot"

  Scenario: A passing test suite
    Given a file in suite "robot" named "<YOUR_FILE>" with:
    """
    TEST FILE CONTENT

    A good test might be a simple passing statement
    """
    When I run `busser test robot`
    Then I should verify some output for the robot plugin
    And the exit status should be 0

  Scenario: A failing test suite
    Given a file in suite "robot" named "<YOUR_FILE>" with:
    """
    TEST FILE CONTENT

    A good test might be a failing test case, raised exception, etc.
    """
    When I run `busser test robot`
    Then I should verify some output for the robot plugin
    And the exit status should not be 0
