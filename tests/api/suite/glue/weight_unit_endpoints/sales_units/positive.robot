*** Settings ***
Suite Setup       SuiteSetup
Test Setup        TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup
    
Get_sales_units_for_product_without_sales_units
    When I send a GET request:    /concrete-products/${bundle_product.concrete.product_1_sku}/sales-units
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response should contain the array of a certain size:   [data]    0
    And Response body has correct self link

Get_sales_units_for_product_with_sales_units
    When I send a GET request:    /concrete-products/${concrete_product.random_weight.sku}/sales-units
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response should contain the array of a certain size:   [data]    ${concrete_product.random_weight.qty_of_units}
    And Each array element of array in response should contain property:    [data]    id
    And Each array element of array in response should contain property with value:    [data]    type    sales-units
    And Each array element of array in response should contain nested property with datatype:    [data]    [attributes][precision]    int
    And Each array element of array in response should contain nested property with datatype in:    [data]    [attributes][conversion]    int    float
    And Each array element of array in response should contain property with value in:   [data]    [attributes][isDisplayed]    True    False
    And Each array element of array in response should contain property with value in:   [data]    [attributes][isDefault]    True    False
    And Each array element of array in response should contain property with value in:    [data]    [attributes][productMeasurementUnitCode]    ${packaging_unit.m}    ${packaging_unit.cm}
    And Response body has correct self link

Get_sales_units_for_product_with_measurement_units_include
    When I send a GET request:    /concrete-products/${concrete_product.random_weight.sku}/sales-units?include=product-measurement-units
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response should contain the array of a certain size:   [data]    ${concrete_product.random_weight.qty_of_units}
    And Each array element of array in response should contain property:    [data]    id
    And Each array element of array in response should contain property with value:    [data]    type    sales-units
    And Response body has correct self link
    And Each array element of array in response should a nested array of a certain size:    [data]    [relationships]   1
    And Response should contain the array of a certain size:    [included]    ${concrete_product.random_weight.qty_of_units}
    And Response include should contain certain entity type:    product-measurement-units
    And Response include element has self link:   product-measurement-units