*** Settings ***
Suite Setup       SuiteSetup
Test Setup        TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup

Get_abstract_product_with_one_concrete
    When I send a GET request:    /abstract-products/${abstract_available_product_with_stock_NESTED.sku}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    abstract-products
    And Response body parameter should be:    [data][id]    ${abstract_available_product_with_stock_NESTED.sku}
    And Response body parameter should be:    [data][attributes][sku]    ${abstract_available_product_with_stock_NESTED.sku}
    And Response body parameter should be:    [data][attributes][merchantReference]    ${abstract_available_product_with_stock_NESTED.merchant_reference}
    And Response body parameter should have datatype:    [data][attributes][reviewCount]    int
    And Response body parameter should be:    [data][attributes][name]    ${abstract_available_product_with_stock_NESTED.name}
    And Response body parameter should be:    [data][attributes][description]    ${abstract_available_product_with_stock_NESTED.description}
    And Response body parameter should be:    [data][attributes][metaTitle]    ${abstract_available_product_with_stock_NESTED.meta_title}
    And Response body parameter should be:    [data][attributes][metaKeywords]    ${abstract_available_product_with_stock_NESTED.meta_keywords}
    And Response body parameter should be:    [data][attributes][metaDescription]    ${abstract_available_product_with_stock_NESTED.meta_description}
    And Response body parameter should be:    [data][attributes][attributeMap][product_concrete_ids][0]    ${abstract_available_product_with_stock_NESTED.concrete_available_product.sku}
    And Response body parameter should be:    [data][attributes][averageRating]    None
    And Response body should contain:    "norm": "DIN EN 1335 Part 1 – 3, DIN EN 12527 + DIN EN 12529"
    And Response body should contain:    "stapelbar": "No"
    And Response body should contain:    "preiseinheit": "piece"
    And Response body should contain:    "reihenverbinder": "No"
    And Response body should contain:    sitzschalenform": "Contoured seat"
    And Response body should contain:    "rollenausfuehrung": "rollers for soft floors"
    And Response body should contain:    "brand": "Prosedia"
    And Response should contain the array of a certain size:    [data][attributes][superAttributesDefinition]    0
    And Response should contain the array of a certain size:    [data][attributes][attributeMap]    4
    And Response should contain the array of a certain size:    [data][attributes][attributeMap][product_concrete_ids]    1
    And Response body parameter should have datatype:    [data][attributes][attributeMap][attribute_variants]    list
    And Response body parameter should have datatype:    [data][attributes][attributeMap][attribute_variant_map]    dict
    And Response body parameter should contain:    [data][attributes][superAttributes]    ${abstract_available_product_with_stock_NESTED.superattribute}
    And Response body parameter should not be EMPTY:    [data][attributes][attributeNames]
    And Response body parameter should not be EMPTY:    [data][attributes][url]
    And Response body has correct self link internal


Get_abstract_product_with_category_nodes_included
    When I send a GET request:    /abstract-products/${abstract_available_product_with_stock_NESTED.sku}?include=category-nodes
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    abstract-products
    And Response should contain the array of a certain size:    [included]    3
    And Response should contain the array of a certain size:    [data][relationships]    1
    And Each array element of array in response should contain property with value:    [data][relationships][category-nodes][data]    type    category-nodes
    And Each array element of array in response should contain property:    [data][relationships][category-nodes][data]    type
    And Each array element of array in response should contain property:    [data][relationships][category-nodes][data]    id
    And Response body parameter should be:    [data][relationships][category-nodes][data][0][id]    ${abstract_available_product_with_stock_NESTED.category_nodes.category_node_14.node_id}
    And Response body parameter should be:    [data][relationships][category-nodes][data][1][id]    ${abstract_available_product_with_stock_NESTED.category_nodes.category_node_11.node_id}
    And Response body parameter should be:    [data][relationships][category-nodes][data][2][id]    ${abstract_available_product_with_stock_NESTED.category_nodes.category_node_12.node_id}
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Each array element of array in response should contain nested property:    [included]    [links]    self
    And Each array element of array in response should contain property with value:    [included]    type    category-nodes
    And Response body parameter should be:    [included][0][attributes][name]    ${abstract_available_product_with_stock_NESTED.category_nodes.category_node_14.name}
    And Response body parameter should be:    [included][1][attributes][name]    ${abstract_available_product_with_stock_NESTED.category_nodes.category_node_11.name}
    And Response body parameter should be:    [included][2][attributes][name]    ${abstract_available_product_with_stock_NESTED.category_nodes.category_node_12.name}
    And Each array element of array in response should contain nested property:    [included]    attributes    nodeId
    And Each array element of array in response should contain nested property:    [included]    attributes    name
    And Each array element of array in response should contain nested property:    [included]    attributes    metaTitle
    And Each array element of array in response should contain nested property:    [included]    attributes    metaKeywords
    And Each array element of array in response should contain nested property:    [included]    attributes    metaDescription
    And Each array element of array in response should contain nested property:    [included]    attributes    isActive
    And Each array element of array in response should contain nested property:    [included]    attributes    order
    And Each array element of array in response should contain nested property:    [included]    attributes    url
    And Each array element of array in response should contain nested property:    [included]    attributes    children
    And Each array element of array in response should contain nested property:    [included]    attributes    parents


Get_abstract_product_with_concrete_products_included
    When I send a GET request:    /abstract-products/${abstract_available_product_with_stock_NESTED.sku}?include=concrete-products
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    abstract-products
    And Response should contain the array of a certain size:    [included]    2
    And Response should contain the array of a certain size:    [data][relationships]    1
    And Response body parameter should not be EMPTY:    [data][relationships]
    And Response body parameter should not be EMPTY:    [data][relationships][concrete-products]
    And Each Array Element Of Array In Response Should Contain Property:    [data][relationships][concrete-products][data]    type
    And Each Array Element Of Array In Response Should Contain Property:    [data][relationships][concrete-products][data]    id
    And Each Array Element Of Array In Response Should Contain Property:    [included]    type
    And Each Array Element Of Array In Response Should Contain Property:    [included]    id
    And Each Array Element Of Array In Response Should Contain Property:    [included]    attributes
    And Each Array Element Of Array In Response Should Contain Property:    [included]    links
    And Each array element of array in response should contain nested property:    [included]    [links]    self
    And Response body parameter should be:    [included][0][type]    concrete-products
    And Response body parameter should be:    [included][0][attributes][sku]    ${abstract_available_product_with_stock_NESTED.concrete_available_product.sku}
    And Response body parameter should not be EMPTY:    [included][0][attributes][isDiscontinued]
    And Response body parameter should be:    [included][0][attributes][discontinuedNote]    None
    And Response body parameter should be:    [included][0][attributes][averageRating]    None
    And Response body parameter should have datatype:    [included][0][attributes][reviewCount]    int
    And Response body parameter should be:    [included][0][attributes][productAbstractSku]    ${abstract_available_product_with_stock_NESTED.sku}
    And Response body parameter should be:    [included][0][attributes][name]    ${abstract_available_product_with_stock_NESTED.concrete_available_product.name}
    And Response body parameter should be:    [included][0][attributes][description]    ${abstract_available_product_with_stock_NESTED.concrete_available_product.description}
    And Response body parameter should be:    [included][0][attributes][metaTitle]    ${abstract_available_product_with_stock_NESTED.concrete_available_product.meta_title}
    And Response body parameter should be:    [included][0][attributes][metaKeywords]    ${abstract_available_product_with_stock_NESTED.concrete_available_product.meta_keywords}
    And Response body parameter should be:    [included][0][attributes][metaDescription]    ${abstract_available_product_with_stock_NESTED.concrete_available_product.meta_description}
    And Response body parameter should contain:    [data][attributes][superAttributes]    ${abstract_available_product_with_stock_NESTED.superattribute}
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributes]
    And Response body parameter should not be EMPTY:    [included][0][attributes][superAttributesDefinition]
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributeNames]

    

Get_abstract_product_with_product_options_included
    When I send a GET request:    /abstract-products/${abstract_available_product_with_stock_NESTED.sku}?include=product-options
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    abstract-products
    And Response should contain the array of a certain size:    [included]    4
    And Response should contain the array of a certain size:    [data][relationships]    1
    And Each array element of array in response should contain property:    [data][relationships][product-options][data]    type
    And Each array element of array in response should contain property:    [data][relationships][product-options][data]    id
    And Response body parameter should be:    [data][relationships][product-options][data][0][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_1.id}
    And Response body parameter should be:    [data][relationships][product-options][data][1][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_2.id}
    And Response body parameter should be:    [data][relationships][product-options][data][2][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_3.id}
    And Response body parameter should be:    [data][relationships][product-options][data][3][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_insurance.id}
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Response include should contain certain entity type:    product-options
    And Each array element of array in response should contain nested property:    [included]    attributes    optionGroupName
    And Each array element of array in response should contain nested property:    [included]    attributes    sku
    And Each array element of array in response should contain nested property:    [included]    attributes    optionName
    And Each array element of array in response should contain nested property:    [included]    attributes    price
    And Each array element of array in response should contain nested property:    [included]    attributes    currencyIsoCode
    And Each array element of array in response should contain nested property:    [included]    [links]    self
    And Response body parameter should be:    [included][0][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_1.id}
    And Response body parameter should be:    [included][0][attributes][optionGroupName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_1.option_group_name}
    And Response body parameter should be:    [included][0][attributes][sku]    ${abstract_available_product_with_stock_NESTED.product_options.OP_1.sku}
    And Response body parameter should be:    [included][0][attributes][optionName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_1.option_name}
    And Each array element of array in response should contain property with value in:    [included]    [attributes][currencyIsoCode]    ${currency_code_eur}    ${currency_code_dollar}
    And Response body parameter should be:    [included][1][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_2.id}
    And Response body parameter should be:    [included][1][attributes][optionGroupName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_2.option_group_name}
    And Response body parameter should be:    [included][1][attributes][sku]    ${abstract_available_product_with_stock_NESTED.product_options.OP_2.sku}
    And Response body parameter should be:    [included][1][attributes][optionName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_2.option_name}
    And Each array element of array in response should contain property with value in:    [included]    [attributes][currencyIsoCode]    ${currency_code_eur}    ${currency_code_dollar}
    And Response body parameter should be:    [included][2][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_3.id}
    And Response body parameter should be:    [included][2][attributes][optionGroupName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_3.option_group_name}
    And Response body parameter should be:    [included][2][attributes][sku]    ${abstract_available_product_with_stock_NESTED.product_options.OP_3.sku}
    And Response body parameter should be:    [included][2][attributes][optionName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_3.option_name}
    And Each array element of array in response should contain property with value in:    [included]    [attributes][currencyIsoCode]    ${currency_code_eur}    ${currency_code_dollar}
    And Response body parameter should be:    [included][3][id]    ${abstract_available_product_with_stock_NESTED.product_options.OP_insurance.id}
    And Response body parameter should be:    [included][3][attributes][optionGroupName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_insurance.option_group_name}
    And Response body parameter should be:    [included][3][attributes][sku]    ${abstract_available_product_with_stock_NESTED.product_options.OP_insurance.sku}
    And Response body parameter should be:    [included][3][attributes][optionName]    ${abstract_available_product_with_stock_NESTED.product_options.OP_insurance.option_name}
    And Each array element of array in response should contain property with value in:    [included]    [attributes][currencyIsoCode]    ${currency_code_eur}    ${currency_code_dollar}


Get_abstract_product_with_product_labels_included
    When I send a GET request:    /abstract-products/${abstract_product_with_label_NESTED.sku}?include=product-labels
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    abstract-products
    And Response body parameter should be:    [data][id]    ${abstract_product_with_label_NESTED.sku}
    And Response should contain the array of a certain size:    [included]    1
    And Response should contain the array of a certain size:    [data][relationships]    1
    And Response body parameter should not be EMPTY:    [data][relationships]
    And Response body parameter should not be EMPTY:    [data][relationships][product-labels]
    And Response include should contain certain entity type:    product-labels
    And Each array element of array in response should contain property:    [data][relationships][product-labels][data]    type
    And Each array element of array in response should contain property:    [data][relationships][product-labels][data]    id
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Response body parameter should be:    [included][0][id]    ${label_id_new}
    And Response body parameter should be:    [included][0][attributes][name]    ${label_name_new}




Get_abstract_product_with_merchants_included
    When I send a GET request:    /abstract-products/${abstract_available_product_with_stock_NESTED.sku}?include=merchants
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    abstract-products
    And Response body parameter should be:    [data][id]    ${abstract_available_product_with_stock_NESTED.sku}
    And Response should contain the array of a certain size:    [included]    1
    And Response should contain the array of a certain size:    [data][relationships]    1
    And Response include should contain certain entity type:    merchants
    And Each array element of array in response should contain property:    [data][relationships][merchants][data]    type
    And Each array element of array in response should contain property:    [data][relationships][merchants][data]    id
    And Response body parameter should be:    [data][relationships][merchants][data][0][type]    merchants
    And Response body parameter should be:    [data][relationships][merchants][data][0][id]    ${merchants.spryker.merchant_id}
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Response body parameter should be:    [included][0][id]    ${merchants.spryker.merchant_id}
    And Response body parameter should be:    [included][0][type]    merchants
    And Response body parameter should be:    [included][0][attributes][merchantName]    ${merchants.spryker.merchant_name}
    And Response body parameter should be:    [included][0][attributes][merchantUrl]    ${merchants.spryker.merchant_url}
    And Response body parameter should be:    [included][0][attributes][contactPersonRole]    ${merchants.spryker.contact_person_role}
    And Response body parameter should be:    [included][0][attributes][contactPersonTitle]    ${merchants.spryker.contact_person_title}
    And Response body parameter should be:    [included][0][attributes][contactPersonFirstName]    ${merchants.spryker.contact_person_first_name}
    And Response body parameter should be:    [included][0][attributes][contactPersonLastName]    ${merchants.spryker.contact_person_last_name}
    And Response body parameter should be:    [included][0][attributes][contactPersonPhone]    ${merchants.spryker.contact_person_phone}
    And Response body parameter should be:    [included][0][attributes][publicEmail]    ${merchants.spryker.public_email}
    And Response body parameter should be:    [included][0][attributes][publicPhone]    ${merchants.spryker.public_phone}
    And Response body parameter should be:    [included][0][attributes][description]    ${merchants.spryker.description}