*** Settings ***
Suite Setup    SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue


*** Test Cases ***
ENABLER
    TestSetup

Retrieves_merchant_opening_hours_by_non_exist_merchant_id
    When I send a GET request:    /merchants/NonExistId/merchant-opening-hours
    Then Response status code should be:    404
    And Response should return error code:    3501
    And Response should return error message:    Merchant not found.