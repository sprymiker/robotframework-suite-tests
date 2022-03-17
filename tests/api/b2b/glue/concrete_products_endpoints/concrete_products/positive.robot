*** Settings ***
Suite Setup       SuiteSetup
Resource    ../../../../../../resources/common/common_api.robot

*** Test Cases ***
Request_product_concrete_by_id
    When I send a GET request:    /concrete-products/${concrete_product_with_alternative_sku}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]   concrete-products
    And Response body parameter should be:    [data][id]    ${concrete_product_with_alternative_sku}
    And Response body parameter should be:    [data][attributes][sku]    ${concrete_product_with_alternative_sku}
    And Response body parameter should be:    [data][attributes][name]    ${concrete_product_with_alternative_sku_name}
    And Response should contain the array of a certain size:    [data][attributes][attributeNames]    7
    And Response should contain the array of a certain size:    [data][attributes][attributes]    7
    And Response body parameter should not be EMPTY:    [data][attributes][description]
    And Response body parameter should not be EMPTY:    [data][attributes][productAbstractSku]
    And Response body parameter should not be EMPTY:    [data][attributes][metaKeywords]
    And Response body parameter should not be EMPTY:    [data][attributes][metaDescription]
    And Response body parameter should be:    [data][attributes][averageRating]    None
    And Response body parameter should be:    [data][attributes][reviewCount]    0
    And Response body has correct self link internal

Request_product_concrete_with_included_image_sets
    When I send a GET request:    /concrete-products/${concrete_product_one_image_set}?include=concrete-product-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]   concrete-products
    And Response body parameter should be:    [data][attributes][sku]    ${concrete_product_one_image_set}
    And Response body parameter should be:    [data][attributes][name]    ${concrete_product_one_image_set_name}
    And Response should contain the array of a certain size:    [data][attributes][attributeNames]    5
    And Response should contain the array of a certain size:    [data][attributes][attributes]    5
    And Response should contain the array of a certain size:    [data][relationships]   1
    And Response include should contain certain entity type:    concrete-product-image-sets
    And Response include element has self link:   concrete-product-image-sets

Request_product_concrete_with_included_availabilities_and_product_prices
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...    AND    I set Headers:    Content-Type=${default_header_content_type}     Authorization=${token}  
    When I send a GET request:    /concrete-products/${concrete_product_with_original_prices}?include=concrete-product-availabilities,concrete-product-prices
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]   concrete-products
    And Response body parameter should be:    [data][attributes][sku]    ${concrete_product_with_original_prices}
    And Response body parameter should be:    [data][attributes][name]    ${concrete_product_with_original_prices_name}
    And Response should contain the array of a certain size:    [data][attributes][attributeNames]    7
    And Response should contain the array of a certain size:    [data][attributes][attributes]    7
    And Response should contain the array of a certain size:    [data][relationships]   2
    And Response include should contain certain entity type:    concrete-product-availabilities
    And Response include should contain certain entity type:    concrete-product-prices
    And Response include element has self link:   concrete-product-prices
    And Response include element has self link:   concrete-product-availabilities

Request_product_concrete_with_included_abstract_product 
    When I send a GET request:    /concrete-products/${concrete_product_multiple_image_set}?include=abstract-products
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]   concrete-products
    And Response body parameter should be:    [data][attributes][sku]    ${concrete_product_multiple_image_set}
    And Response body parameter should be:    [data][attributes][name]    ${concrete_product_multiple_image_set_name}
    And Response should contain the array of a certain size:    [data][attributes][attributeNames]    7
    And Response should contain the array of a certain size:    [data][attributes][attributes]    7
    And Response should contain the array of a certain size:    [data][relationships]   1
    And Response include should contain certain entity type:    abstract-products
    And Response include element has self link:   abstract-products