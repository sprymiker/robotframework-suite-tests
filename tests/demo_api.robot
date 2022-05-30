*** Settings ***
Suite Setup    SuiteSetup
Resource    ../resources/common/common_api.robot
Default Tags    glue

*** Variables ***
${default_header_content_type}    application/vnd.api+json
${yves_user_email}    george.freeman@spryker.com
${yves_user_password}    change123

*** Test Cases ***
Get_access_token_for_customer
    When I send a POST request:    /access-tokens    {"data":{"type":"access-tokens","attributes":{"username":"${yves_user_email}","password":"${yves_user_password}"}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]    access-tokens
    And Response body parameter should be greater than:    [data][attributes][expiresIn]    0
    And Response body parameter should be less than:    [data][attributes][expiresIn]    30000
    And Response body parameter should not be EMPTY:    [data][attributes][tokenType]
    And Response body parameter should not be EMPTY:    [data][attributes][accessToken]
    And Response body parameter should not be EMPTY:    [data][attributes][refreshToken]
    And Response body has correct self link internal
