*** Settings ***
Resource    ../../../../../../resources/common/common_api.robot
Suite Setup    SuiteSetup
Test Setup    TestSetup
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup
    
Get_agent_access_token_by_empty_email_and_empty_password
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "","password": ""}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_with_blank_spaces
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username":" " ,"password":" "}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_by_valid_email_and_empty_password
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "${agent_email}","password": ""}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_by_empty_email_and_valid_password
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "","password": "${agent_password}"}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_by_wrong_email_format
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "abc","password": "${agent_password}"}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_by_non_agent_email_and_password
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "${non_agent_email}","password": "${non_agent_password}"}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_by_invalid_email_and_invalid_password
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "spryker1232@gmail.com","password": "1234"}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_by_invalid_email_and_valid_password
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "spryker1232@gmail.com","password": "${agent_password}"}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_agent_access_token_by_vaild_email_and_invalid_password
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "${agent_email}","password": "12345"}}}
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    4101
    And Response should return error message:    Failed to authenticate an agent.

Get_access_token_by_invalid_data_type
    When I send a POST request:    /agent-access-tokens    {"data": {"type": "token","attributes": {"username": "${agent_email}","password": "${agent_password}"}}}
    Then Response status code should be:    400
    And Response reason should be:    Bad Request
    And Response should return error message:    Invalid type.