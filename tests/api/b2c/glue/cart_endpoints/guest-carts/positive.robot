*** Settings ***
Suite Setup    SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
#POST requests
Create_guest_cart
    [Setup]    I set Headers:    Content-Type=${default_header_content_type}    X-Anonymous-Customer-Unique-Id=${random}
    When I send a POST request:    /guest-cart-items    {"data": {"type": "guest-cart-items","attributes": {"sku": "${concrete_product_with_concrete_product_alternative_sku}","quantity": 1}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response body parameter should be:    [data][type]    guest-carts
    And Response body parameter should not be EMPTY:    [data][id]
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should not be EMPTY:    [data][attributes][totals][expenseTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][discountTotal]
    Response body parameter should be greater than:    [data][attributes][totals][taxTotal]    0
    Response body parameter should be greater than:    [data][attributes][totals][subtotal]    0
    Response body parameter should be greater than:    [data][attributes][totals][grandTotal]    0
    Response body parameter should be greater than:    [data][attributes][totals][priceToPay]    0

Retrieve_guest_cart
    [Setup]    Create a guest cart:    ${random}    ${concrete_product_with_concrete_product_alternative_sku}    7
    When I send a GET request:    /guest-carts
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    guest-carts
    And Response body parameter should not be EMPTY:    [data][0][id]
    And Response body parameter should be:    [data][0][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][0][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][0][attributes][store]    ${store_de}
    And Response body parameter should not be EMPTY:    [data][0][attributes][totals][expenseTotal]
    And Response body parameter should not be EMPTY:    [data][0][attributes][totals][discountTotal]
    Response body parameter should be greater than:    [data][0][attributes][totals][taxTotal]    0
    Response body parameter should be greater than:    [data][0][attributes][totals][subtotal]    0
    Response body parameter should be greater than:    [data][0][attributes][totals][grandTotal]    0
    Response body parameter should be greater than:    [data][0][attributes][totals][priceToPay]    0

Retrieve_guest_cart_by_id
    [Setup]    Create a guest cart:    ${random}    ${concrete_product_with_concrete_product_alternative_sku}    7
    When I send a GET request:    /guest-carts/${guest_cart_id}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    guest-carts
    And Response body parameter should be:    [data][id]    ${guest_cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should not be EMPTY:    [data][attributes][totals][expenseTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][discountTotal]
    Response body parameter should be greater than:    [data][attributes][totals][taxTotal]    0
    Response body parameter should be greater than:    [data][attributes][totals][subtotal]    0
    Response body parameter should be greater than:    [data][attributes][totals][grandTotal]    0
    Response body parameter should be greater than:    [data][attributes][totals][priceToPay]    0

Retrieve_guest_cart_including_cart_items
    [Setup]    Create a guest cart:    ${random}    ${concrete_product_with_concrete_product_alternative_sku}    7
    When I send a GET request:    /guest-carts/${guest_cart_id}?include=guest-cart-items
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    guest-carts
    And Response body parameter should be:    [data][id]    ${guest_cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][relationships][guest-cart-items][data][0][type]    guest-cart-items
    And Response body parameter should be:    [data][relationships][guest-cart-items][data][0][id]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][0][type]    guest-cart-items
    And Response body parameter should not be EMPTY:    [included][0][id]
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Each array element of array in response should contain value:    [included]    sku
    And Each array element of array in response should contain value:    [included]    quantity
    And Each array element of array in response should contain value:    [included]    groupKey
    And Each array element of array in response should contain value:    [included]    abstractSku
    And Each array element of array in response should contain value:    [included]    amount
    And Each array element of array in response should contain value:    [included]    calculations
    And Each array element of array in response should contain value:    [included]    unitPrice
    And Each array element of array in response should contain value:    [included]    sumPrice
    And Each array element of array in response should contain value:    [included]    taxRate
    And Each array element of array in response should contain value:    [included]    unitNetPrice
    And Each array element of array in response should contain value:    [included]    sumNetPrice
    And Each array element of array in response should contain value:    [included]    unitGrossPrice
    And Each array element of array in response should contain value:    [included]    sumGrossPrice
    And Each array element of array in response should contain value:    [included]    unitTaxAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    sumTaxAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    sumSubtotalAggregation
    And Each array element of array in response should contain value:    [included]    unitSubtotalAggregation
    And Each array element of array in response should contain value:    [included]    unitProductOptionPriceAggregation
    And Each array element of array in response should contain value:    [included]    sumProductOptionPriceAggregation
    And Each array element of array in response should contain value:    [included]    unitDiscountAmountAggregation
    And Each array element of array in response should contain value:    [included]    sumDiscountAmountAggregation
    And Each array element of array in response should contain value:    [included]    unitDiscountAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    sumDiscountAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    unitPriceToPayAggregation
    And Each array element of array in response should contain value:    [included]    sumPriceToPayAggregation
    And Each array element of array in response should contain value:    [included]    selectedProductOptions

Retrieve_guest_cart_including_cart_rules
    [Setup]    Create a guest cart:    ${random}    ${concrete_product_with_concrete_product_alternative_sku}    7
    When I send a GET request:    /guest-carts/${guest_cart_id}?include=cart-rules
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    guest-carts
    And Response body parameter should be:    [data][id]    ${guest_cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Each array element of array in response should contain property with value:    [data][relationships][cart-rules][data]    type    cart-rules
    And Each array element of array in response should contain property:    [data][relationships][cart-rules][data]    id
    And Each array element of array in response should contain property with value:    [included]    type    cart-rules
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Each array element of array in response should contain value:    [included]    amount
    And Each array element of array in response should contain value:    [included]    code
    And Each array element of array in response should contain value:    [included]    discountType
    And Each array element of array in response should contain value:    [included]    displayName
    And Each array element of array in response should contain value:    [included]    isExclusive
    And Each array element of array in response should contain value:    [included]    expirationDateTime
    And Each array element of array in response should contain value:    [included]    discountPromotionAbstractSku
    And Each array element of array in response should contain value:    [included]    discountPromotionQuantity

Converting_guest_cart_to_regular
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
        ...   AND    I set Headers:    Authorization=${token}
        ...   AND    Find or create customer cart
        ...   AND    Cleanup all items in the cart:    ${cart_id}
        ...   AND    Create a guest cart:    ${random}    ${concrete_product_with_concrete_product_alternative_sku}    1
        ...   AND    I set Headers:     X-Anonymous-Customer-Unique-Id=${x_anonymous_customer_unique_id}
        ...   AND    I get access token for the customer:    ${yves_user_email}
        ...   AND    I set Headers:    Authorization=${token}
    When I send a GET request:    /carts?include=items
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    carts
    And Response body parameter should be:    [data][0][id]    ${cart_id}
    And Response body parameter should be:    [data][0][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][0][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][0][attributes][store]    ${store_de}
    And Response body parameter should not be EMPTY:    [data][0][attributes][totals][expenseTotal]
    And Response body parameter should not be EMPTY:    [data][0][attributes][totals][discountTotal]
    Response body parameter should be greater than:    [data][0][attributes][totals][taxTotal]    0
    Response body parameter should be greater than:    [data][0][attributes][totals][subtotal]    0
    Response body parameter should be greater than:    [data][0][attributes][totals][grandTotal]    0
    Response body parameter should be greater than:    [data][0][attributes][totals][grandTotal]    0
    And Response body parameter should be:    [included][0][type]    items
    And Response body parameter should be:    [included][0][attributes][sku]    ${concrete_product_with_concrete_product_alternative_sku}
