*** Settings ***
Suite Setup    SuiteSetup
Test Setup     TestSetup
Resource       ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup
    
#GET requests
Get_availability_notifications_without_customerId
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "${yves_user_email}"}}}
    ...  AND    Response status code should be:    201
    ...  AND    Save value to a variable:    [data][id]    availability_notification_id
    When I send a GET request:    /customers//availability-notifications
    Then Response status code should be:    403
    And Response reason should be:    Forbidden
    And Response should return error code:    4606
    And Response should return error message:    Unauthorized request.
    [Teardown]    Run Keywords    I send a DELETE request:    /availability-notifications/${availability_notification_id}
    ...  AND    Response status code should be:    204

Get_availability_notifications_with_invalid_access_token
    [Setup]    Run Keywords    I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "${yves_user_email}"}}}
    ...  AND    Response status code should be:    201
    ...  AND    Save value to a variable:    [data][id]    availability_notification_id
    ...  AND    I set Headers:    Authorization=325tr
    When I send a GET request:    /customers/${yves_user_reference}/availability-notifications
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error code:    001
    And Response should return error message:    Invalid access token.
    [Teardown]    Run Keywords    I set Headers:    Authorization=
    ...  AND    I send a DELETE request:    /availability-notifications/${availability_notification_id}
    ...  AND    Response status code should be:    204

Get_availability_notifications_without_access_token
    [Setup]    Run Keywords    I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "${yves_user_email}"}}}
    ...  AND    Response status code should be:    201
    ...  AND    Save value to a variable:    [data][id]    availability_notification_id
    ...  AND    I set Headers:    Authorization=
    When I send a GET request:    /customers/${yves_user_reference}/availability-notifications
    Then Response status code should be:    403
    And Response reason should be:    Forbidden
    And Response should return error code:    002
    And Response should return error message:    Missing access token.
    [Teardown]    Run Keywords    I send a DELETE request:    /availability-notifications/${availability_notification_id}
    ...  AND    Response status code should be:    204

#POST requests
Subscribe_to_availability_notifications_with_invalid_sku
#This test fails due to the bug https://spryker.atlassian.net/browse/CC-15970
    When I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "fake","email": "${yves_user_email}"}}}
    Then Response status code should be:    422
    And Response reason should be:    Unprocessable Content
    And Each array element of array in response should contain property with value:    [errors]    code    901
    And Each array element of array in response should contain property with value:    [errors]    status    422
    And Array in response should contain property with value:    [errors]    detail    sku => This value is not a valid sku.

Subscribe_to_availability_notifications_with_invalid_email
    When I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "gmail"}}}
    Then Response status code should be:    422
    And Response reason should be:    Unprocessable Content
    And Each array element of array in response should contain property with value:    [errors]    code    901
    And Each array element of array in response should contain property with value:    [errors]    status    422
    And Array in response should contain property with value:    [errors]    detail    email => This value is not a valid email address.

Subscribe_to_availability_notifications_with_empty_sku_and_email
    When I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "","email": ""}}}
    Then Response status code should be:    422
    And Response reason should be:    Unprocessable Content
    And Each array element of array in response should contain property with value:    [errors]    code    901
    And Each array element of array in response should contain property with value:    [errors]    status    422
    And Array in response should contain property with value:    [errors]    detail    sku => This value should not be blank.
    And Array in response should contain property with value:    [errors]    detail    email => This value should not be blank.

Subscribe_to_availability_notifications_without_sku_and_email
    When I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {}}}
    Then Response status code should be:    422
    And Response reason should be:    Unprocessable Content
    And Each array element of array in response should contain property with value:    [errors]    code    901
    And Each array element of array in response should contain property with value:    [errors]    status    422
    And Array in response should contain property with value:    [errors]    detail    sku => This field is missing.
    And Array in response should contain property with value:    [errors]    detail    email => This field is missing.

Subscribe_to_availability_notifications_with_existing_subscription
    [Setup]    Run Keywords    I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "${yves_user_email}"}}}
    ...  AND    Response status code should be:    201
    ...  AND    Save value to a variable:    [data][id]    availability_notification_id
    When I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "${yves_user_email}"}}}
    Then Response status code should be:    422
    And Response reason should be:    Unprocessable Content
    And Response should return error code:    4602
    And Response should return error message:    Subscription already exists.
    [Teardown]    Run Keywords    I send a DELETE request:    /availability-notifications/${availability_notification_id}
    ...  AND    Response status code should be:    204

#DELETE requests
Delete_availability_notifications_with_invalid_availability_notification_id
    [Setup]    Run Keywords    I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "${yves_user_email}"}}}
    ...  AND    Response status code should be:    201
    ...  AND    Save value to a variable:    [data][id]    availability_notification_id
    When I send a DELETE request:    /availability-notifications/7fc6ebf
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error code:    4603
    And Response should return error message:    "Subscription doesnt exist."
    [Teardown]    Run Keywords    I send a DELETE request:    /availability-notifications/${availability_notification_id}
    ...  AND    Response status code should be:    204

Delete_availability_notifications_without_availability_notification_id
    [Setup]    Run Keywords    I send a POST request:    /availability-notifications    {"data": {"type": "availability-notifications","attributes": {"sku": "${concrete_product_with_alternative_sku}","email": "${yves_user_email}"}}}
    ...  AND    Response status code should be:    201
    ...  AND    Save value to a variable:    [data][id]    availability_notification_id
    When I send a DELETE request:    /availability-notifications/
    Then Response status code should be:    400
    And Response reason should be:    Bad Request
    And Response should return error message:    Resource id is not specified.
    [Teardown]    Run Keywords    I send a DELETE request:    /availability-notifications/${availability_notification_id}
    ...  AND    Response status code should be:    204