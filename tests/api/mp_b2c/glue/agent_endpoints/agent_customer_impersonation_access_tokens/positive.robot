*** Settings ***
Suite Setup       SuiteSetup
Test Setup        TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup

Agent_can_get_customer_impersonation_token
    [Documentation]    bug:https://spryker.atlassian.net/browse/CC-17010
    [Tags]    skip-due-to-issue   
    [Setup]    Run Keywords    I send a POST request:    /agent-access-tokens    {"data": {"type": "agent-access-tokens","attributes": {"username": "${agent.email}","password": "${agent.password}"}}}
    ...    AND    Response status code should be:    201
    ...    AND    Save value to a variable:    [data][attributes][accessToken]    agent_token
    ...    AND    I Set Headers:    Content-Type=${default_header_content_type}    Authorization=Bearer ${agent_token}
    When I send a POST request:    /agent-customer-impersonation-access-tokens    {"data": {"type": "agent-customer-impersonation-access-tokens","attributes":{"customerReference": "${yves_user.reference}"}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    None
    And Response body parameter should be:    [data][type]    agent-customer-impersonation-access-tokens
    And Response body parameter should be:    [data][attributes][tokenType]    Bearer
    And Response body parameter should be greater than:    [data][attributes][expiresIn]    25000
    And Response body parameter should not be EMPTY:    [data][attributes][accessToken]
    And Response body parameter should not be EMPTY:    [data][attributes][refreshToken]
    And Response body has correct self link internal