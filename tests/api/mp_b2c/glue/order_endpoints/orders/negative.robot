*** Settings ***
Suite Setup       SuiteSetup
Resource    ../../../../../../resources/common/common_api.robot
Test Setup        TestSetup
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup
#GET requests
Get_order_by_order_id_with_invalid_access_token
    [Setup]    I set Headers:    Authorization=fake_token
    When I send a GET request:    /orders/order_id
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error message:    Invalid access token.
    And Response should return error code:    001

Get_order_by_order_id_without_access_token
    [Setup]    I set Headers:    Authorization=
    When I send a GET request:    /orders/order_id
    Then Response status code should be:    403
    And Response reason should be:    Forbidden
    And Response should return error message:    Missing access token.
    And Response should return error code:    002

Get_order_with_invalid_order_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    When I send a GET request:    /orders/fake_order_id
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error message:    "Cant find order by the given order reference"
    And Response should return error code:    801


Get_customer_orders_list_with_invalid_access_token
    [Setup]    I set Headers:    Authorization=fake_token
    When I send a GET request:    /customers/${yves_user_reference}/orders
    Then Response status code should be:    401
    And Response reason should be:    Unauthorized
    And Response should return error message:    Invalid access token.
    And Response should return error code:    001

Get_customer_orders_list_without_access_token
    [Setup]    I set Headers:    Authorization=
    When I send a GET request:    /customers/${yves_user_reference}/orders
    Then Response status code should be:    403
    And Response reason should be:    Forbidden
    And Response should return error message:    Missing access token.
    And Response should return error code:    002

Get_order_by_order_id_from_another_customer
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cartId}/items    {"data":{"type":"items","attributes":{"sku":"${concrete_product_with_concrete_product_alternative_sku}","quantity":1,"merchantReference":"${merchants.sony_experts.merchant_id}"}}}
    ...  AND    I send a POST request:    /checkout    {"data": {"type": "checkout","attributes": {"customer": {"email": "${yves_user_email}","salutation": "${yves_user_salutation}","firstName": "${yves_user_first_name}","lastName": "${yves_user_last_name}"},"idCart": "${CartId}","billingAddress": {"salutation": "${yves_user_salutation}","firstName": "${yves_user_first_name}","lastName": "${yves_user_last_name}","address1": "${default_address1}","address2": "${default_address2}","address3": "${default_address3}","zipCode": "${default_zipCode}","city": "${default_city}","iso2Code": "${default_iso2Code}","company": "${default_company}","phone": "${default_phone}","isDefaultBilling": False,"isDefaultShipping": False},"shippingAddress": {"salutation": "${yves_user_salutation}","firstName": "${yves_user_first_name}","lastName": "${yves_user_last_name}","address1": "${default_address1}","address2": "${default_address2}","address3": "${default_address3}","zipCode": "${default_zipCode}","city": "${default_city}","iso2Code": "${default_iso2Code}","company": "${default_company}","phone": "${default_phone}","isDefaultBilling": False,"isDefaultShipping": False},"payments": [{"paymentProviderName": "${payment_provider_name}","paymentMethodName": "${payment_method_name}"}],"shipment": {"idShipmentMethod": 1},"items": ["${concrete_product_with_concrete_product_alternative_sku}"]}}}
    ...  AND    Save value to a variable:    [data][attributes][orderReference]    order_id
    ...  AND    I get access token for the customer:    ${yves_second_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    When I send a GET request:    /orders/${order_id}
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error message:    "Cant find order by the given order reference"
    And Response should return error code:    801


    
Get_customer_orders_list_with_invalid_customer_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    When I send a GET request:    /customers/yves_user_reference/orders
    Then Response status code should be:    403
    And Response reason should be:    Forbidden
    And Response should return error message:    Unauthorized request.
    And Response should return error code:    802

Get_customer_orders_list_without_customer_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    When I send a GET request:    /customers//orders
    Then Response status code should be:    403
    And Response reason should be:    Forbidden
    And Response should return error message:    Unauthorized request.
    And Response should return error code:    802

Get_customer_orders_list_from_another_customer
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    When I send a GET request:    /customers/${yves_second_user_reference}/orders
    Then Response status code should be:    403
    And Response reason should be:    Forbidden
    And Response should return error message:    Unauthorized request.
    And Response should return error code:    802