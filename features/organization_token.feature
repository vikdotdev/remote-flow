Feature: Organization Token
  In order to read the page
  As a admin
  I should auth like admin

  Scenario: View organization token for admin
    Given Auth like admin
    When I am on organization page
    Then I should see organization token