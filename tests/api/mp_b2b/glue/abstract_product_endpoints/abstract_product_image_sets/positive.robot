*** Settings ***
Suite Setup       SuiteSetup
Test Setup        TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup
    
Get_abstract_image_sets_with_1_concrete
    When I send a GET request:    /abstract-products/${abstract_available_with_stock_and_never_out_of_stock}/abstract-product-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][id]    ${abstract_available_with_stock_and_never_out_of_stock}
    And Response body parameter should be:    [data][0][type]    abstract-product-image-sets
    And Response should contain the array of a certain size:    [data][0][attributes][imageSets]   1
    And Response should contain the array of a certain size:    [data][0][attributes][imageSets][0][images]    1
    And Response body parameter should not be EMPTY:   [data][0][attributes][imageSets][0][images][0][externalUrlLarge]
    And Response body parameter should not be EMPTY:    [data][0][attributes][imageSets][0][images][0][externalUrlSmall]
    And Response body parameter should be:    [data][0][attributes][imageSets][0][name]    default
    And Response body has correct self link

Get_abstract_image_sets_with_3_concretes
    When I send a GET request:    /abstract-products/${abstract_available_product_with_3_concretes}/abstract-product-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][id]    ${abstract_available_product_with_3_concretes}
    And Response should contain the array of a certain size:    [data][0][attributes][imageSets]   1
    And Response should contain the array of a certain size:    [data][0][attributes][imageSets][0][images]    1
    And Response body parameter should not be EMPTY:   [data][0][attributes][imageSets][0][images][0][externalUrlLarge]
    And Response body parameter should not be EMPTY:    [data][0][attributes][imageSets][0][images][0][externalUrlSmall]
    And Response body parameter should be:    [data][0][attributes][imageSets][0][name]    default
    And Response body has correct self link


Get_abstract_product_with_1_concrete_with_include_abstract_product_image_sets
    When I send a GET request:    /abstract-products/${abstract_available_with_stock_and_never_out_of_stock}?include=abstract-product-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response should contain the array of a certain size:    [included]    1
    And Response should contain the array of a certain size:    [data][relationships]    1
    And Response body parameter should not be EMPTY:    [data][relationships][abstract-product-image-sets]
    And Response body parameter should be:    [data][relationships][abstract-product-image-sets][data][0][type]    abstract-product-image-sets
    And Response body parameter should be:    [data][relationships][abstract-product-image-sets][data][0][id]    ${abstract_available_with_stock_and_never_out_of_stock}
    And Response body parameter should be:    [included][0][id]    ${abstract_available_with_stock_and_never_out_of_stock}
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Each array element of array in response should contain nested property:    [included]    [links]    self
    And Each array element of array in response should contain property with value:    [included]    type    abstract-product-image-sets
    And Each array element of array in response should contain nested property:    [included]    attributes    imageSets
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets]    name
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets]    images
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets][0][images]    externalUrlLarge
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets][0][images]    externalUrlSmall
    And Response body has correct self link internal


Get_abstract_product_with_3_concretes_with_include_abstract_product_image_sets
    When I send a GET request:    /abstract-products/${abstract_available_product_with_3_concretes}?include=abstract-product-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response should contain the array of a certain size:    [included]    1
    And Response should contain the array of a certain size:    [data][relationships]    1
    And Each array element of array in response should contain property:    [data][relationships][abstract-product-image-sets][data]    type
    And Each array element of array in response should contain property:    [data][relationships][abstract-product-image-sets][data]    id
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Each array element of array in response should contain nested property:    [included]    [links]    self
    And Each array element of array in response should contain property with value:    [included]    type    abstract-product-image-sets
    And Each array element of array in response should contain nested property:    [included]    attributes    imageSets
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets]    name
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets]    images
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets][0][images]    externalUrlLarge
    And Each array element of array in response should contain nested property:    [included]    [attributes][imageSets][0][images]    externalUrlSmall
    And Response body has correct self link internal