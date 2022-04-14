*** Settings ***
Suite Setup       SuiteSetup
Resource    ../../../../../../resources/common/common_api.robot

*** Test Cases ***
#####POST#####
Add_one_item_to_cart
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
       ...  AND    I set Headers:    Authorization=${token}
       ...  AND    Find or create customer cart
       ...  AND    Cleanup all items in the cart:    ${cart_id}
    When I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${concrete_product_with_concrete_product_alternative_sku}", "quantity": "1"}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should not be EMPTY:    [data][attributes][totals][expenseTotal]
    And Response body parameter should not be EMPTY:   [data][attributes][totals][discountTotal]
    And Response body parameter should be greater than:    [data][attributes][totals][taxTotal]    1
    And Response body parameter should be greater than:    [data][attributes][totals][subtotal]    1
    And Response body parameter should be greater than:    [data][attributes][totals][grandTotal]    1
    And Response body parameter should be greater than:    [data][attributes][totals][priceToPay]    1
    And Response body parameter should not be EMPTY:    [data][links][self]

Add_two_items_to_cart_with_included_items_concrete_products_and_abstract_products
   [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
          ...  AND    I set Headers:    Authorization=${token}
          ...  AND    Find or create customer cart
          ...  AND    Cleanup all items in the cart:    ${cart_id}
    When I send a POST request:    /carts/${cart_id}/items?include=items,concrete-products,abstract-products    {"data": {"type": "items","attributes": {"sku": "${concrete_product_with_concrete_product_alternative_sku}", "quantity": "2"}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should not be EMPTY:    [data][attributes][totals][grandTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][discounts]
    And Response body parameter should not be EMPTY:    [data][links][self]
    And Response should contain the array of a certain size:    [data][relationships][items][data]    1
    And Response should contain the array of a certain size:    [included]    4
    And Response include should contain certain entity type:    items
    And Response include should contain certain entity type:    concrete-products
    And Response include should contain certain entity type:    abstract-products
    And Response include element has self link:   items
    And Response include element has self link:   concrete-products
    And Response include element has self link:   abstract-products
    And Response body parameter should be:    [included][3][type]    items
    And Response body parameter should be:    [included][3][id]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][3][attributes][sku]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][3][attributes][quantity]    2
    And Response body parameter should be:    [included][3][attributes][groupKey]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][3][attributes][abstractSku]    ${abstract_product_with_alternative_sku}
    And Response body parameter should be:    [included][3][attributes][amount]    None
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitPrice]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumPrice]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][taxRate]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitNetPrice]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumNetPrice]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitGrossPrice]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumGrossPrice]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitTaxAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumTaxAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumSubtotalAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitSubtotalAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitProductOptionPriceAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumProductOptionPriceAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitDiscountAmountAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumDiscountAmountAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitDiscountAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumDiscountAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][unitPriceToPayAggregation]
    And Response body parameter should not be EMPTY:    [included][3][attributes][calculations][sumPriceToPayAggregation]
    And Response should contain the array of a certain size:    [included][3][attributes][selectedProductOptions]    0

Get_a_cart_with_included_items_and_concrete_products
     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
              ...  AND    I set Headers:    Authorization=${token}
              ...  AND    Find or create customer cart
              ...  AND    Cleanup all items in the cart:    ${cart_id}
              ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${concrete_product_with_concrete_product_alternative_sku}", "quantity": "2"}}}
    When I send a GET request:    /carts/${cart_id}?include=items,concrete-products
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should not be EMPTY:    [data][attributes][totals][grandTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][discounts]
    And Response body parameter should not be EMPTY:    [data][links][self]
    And Response should contain the array of a certain size:    [data][relationships][items][data]    1
    And Response should contain the array of a certain size:    [included]    2
    And Response include should contain certain entity type:    items
    And Response include should contain certain entity type:    concrete-products
    And Response include element has self link:   items
    And Response include element has self link:   concrete-products
    And Response body parameter should be:    [included][1][type]    items
    And Response body parameter should be:    [included][1][id]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][1][attributes][sku]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][1][attributes][quantity]    2
    And Response body parameter should be:    [included][1][attributes][groupKey]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][1][attributes][abstractSku]    ${abstract_product_with_alternative_sku}
    And Response body parameter should be:    [included][1][attributes][amount]    None
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitPrice]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumPrice]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][taxRate]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitNetPrice]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumNetPrice]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitGrossPrice]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumGrossPrice]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitTaxAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumTaxAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumSubtotalAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitSubtotalAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitProductOptionPriceAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumProductOptionPriceAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitDiscountAmountAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumDiscountAmountAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitDiscountAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumDiscountAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][unitPriceToPayAggregation]
    And Response body parameter should not be EMPTY:    [included][1][attributes][calculations][sumPriceToPayAggregation]
    And Response should contain the array of a certain size:    [included][1][attributes][selectedProductOptions]    0

Add_ten_items_to_cart_with_included_cart_rules_and_promotional_items
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
                  ...  AND    I set Headers:    Authorization=${token}
                  ...  AND    Find or create customer cart
                  ...  AND    Cleanup all items in the cart:    ${cart_id}
    When I send a POST request:    /carts/${cart_id}/items?include=cart-rules,promotional-items   {"data": {"type": "items","attributes": {"sku": "${concrete_product_with_concrete_product_alternative_sku}","quantity": 10}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should not be EMPTY:    [data][links][self]
    And Response should contain the array of a certain size:    [data][relationships][cart-rules][data]    1
    And Response should contain the array of a certain size:    [data][relationships][promotional-items][data]    1
    And Response should contain the array of a certain size:    [included]    3
    And Response include should contain certain entity type:    cart-rules
    And Response include should contain certain entity type:    items
    And Response include element has self link:   cart-rules
    And Response include element has self link:   items

Add_bundle_to_cart_with_included_bundle_items_and_bundled_items
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
      ...  AND    I set Headers:    Authorization=${token}
      ...  AND    Find or create customer cart
      ...  AND    Cleanup all items in the cart:    ${cart_id}
    When I send a POST request:    /carts/${cart_id}/items?include=bundle-items,bundled-items    {"data": {"type": "items","attributes": {"sku": "${bundle_product_concrete_sku}","quantity": 1}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should not be EMPTY:    [data][attributes][totals][expenseTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][discountTotal]
    And Response body parameter should be greater than:    [data][attributes][totals][taxTotal]    1
    And Response body parameter should be greater than:    [data][attributes][totals][subtotal]    1
    And Response body parameter should be greater than:    [data][attributes][totals][grandTotal]    1
    And Response body parameter should be greater than:    [data][attributes][totals][priceToPay]    1
    And Response body parameter should not be EMPTY:    [data][links][self]
    And Response should contain the array of a certain size:    [data][relationships][bundle-items][data]    1
    And Response should contain the array of a certain size:    [included]    4
    And Response include should contain certain entity type:    bundle-items
    And Response include should contain certain entity type:    bundled-items
    And Response include element has self link:   bundle-items
    And Response include element has self link:   bundled-items
    And Response body parameter should be:    [included][0][type]    bundled-items
    And Response body parameter should be:    [included][0][attributes][sku]    ${bundled_product_1_concrete_sku}
    And Response body parameter should be:    [included][1][type]    bundled-items
    And Response body parameter should be:    [included][1][attributes][sku]    ${bundled_product_2_concrete_sku}
    And Response body parameter should be:    [included][2][type]    bundled-items
    And Response body parameter should be:    [included][2][attributes][sku]    ${bundled_product_3_concrete_sku}
    And Response body parameter should be:    [included][3][type]    bundle-items
    And Response body parameter should be:    [included][3][attributes][sku]    ${bundle_product_concrete_sku}
    And Response body parameter should be:    [included][3][attributes][quantity]    1
    And Response body parameter should be:    [included][3][attributes][groupKey]    ${bundle_product_concrete_sku}
    And Response body parameter should be:    [included][3][attributes][abstractSku]    ${bundle_product_abstract_sku}

Add_product_with_options_to_cart
     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
          ...  AND    I set Headers:    Authorization=${token}
          ...  AND    Find or create customer cart
          ...  AND    Cleanup all items in the cart:    ${cart_id}
    When I send a POST request:    /carts/${cart_id}/items?include=items    {"data":{"type": "items","attributes":{"sku": "${concrete_product_with_concrete_product_alternative_sku}","quantity": 1,"productOptions": [{ "sku": "${product_option_1}"},{ "sku": "${product_option_2}"}] }}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][type]    carts
    And Response should contain the array of a certain size:    [data][relationships][items][data]    1
    And Response should contain the array of a certain size:    [included]    1
    And Response include should contain certain entity type:    items
    And Response include element has self link:   items
    And Response body parameter should contain:    [included][0][id]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][0][attributes][sku]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should contain:    [included][0][attributes][groupKey]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be greater than:    [included][0][attributes][calculations][unitProductOptionPriceAggregation]    1
    And Response body parameter should be greater than:    [included][0][attributes][calculations][sumProductOptionPriceAggregation]    1
    And Response should contain the array of a certain size:    [included][0][attributes][selectedProductOptions]    2
    Each array element of array in response should contain property:    [included][0][attributes][selectedProductOptions]    optionGroupName
    Each array element of array in response should contain property:    [included][0][attributes][selectedProductOptions]    sku
    Each array element of array in response should contain property:    [included][0][attributes][selectedProductOptions]    optionName
    Each array element of array in response should contain property:    [included][0][attributes][selectedProductOptions]    price

Change_item_qty_in_cart
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
      ...  AND    I set Headers:    Authorization=${token}
      ...  AND    Find or create customer cart
      ...  AND    Cleanup all items in the cart:    ${cart_id}
      ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${concrete_product_with_concrete_product_alternative_sku}", "quantity": "1"}}}
    When I send a PATCH request:    /carts/${cart_id}/items/${concrete_product_with_concrete_product_alternative_sku}?include=items  {"data":{"type": "items","attributes":{"quantity": 2}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [included][0][attributes][sku]    ${concrete_product_with_concrete_product_alternative_sku}
    And Response body parameter should be:    [included][0][attributes][quantity]    2

####### DELETE #######
Delete_item_form_cart
     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
          ...  AND    I set Headers:    Authorization=${token}
          ...  AND    Find or create customer cart
          ...  AND    Cleanup all items in the cart:    ${cart_id}
          ...  AND    I send a POST request:    /carts/${cart_id}/items?include=items    {"data": {"type": "items","attributes": {"sku": "${concrete_product_with_concrete_product_alternative_sku}", "quantity": "1"}}}
          ...  AND    Save value to a variable:    [included][0][attributes][groupKey]    item_group_key
    When I send a DELETE request:    /carts/${cart_id}/items/${item_group_key}
    Then Response status code should be:    204
    And Response reason should be:    No Content