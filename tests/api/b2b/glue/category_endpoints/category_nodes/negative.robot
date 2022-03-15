*** Settings ***
Suite Setup    SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
Get_category_node_by_invalid_id
    When I send a GET request:    /category-nodes/${category_node_invalid_id}
    Then Response status code should be:    400
    And Response should return error code:    701
    And Response should return error message:    Category node id has not been specified or invalid.


Get_category_node_by_non_exist_id
    When I send a GET request:    /category-nodes/${category_node_non_exists_id}
    Then Response status code should be:    404
    And Response should return error code:    703
    And Response should return error message:    "Cant find category node with the given id."