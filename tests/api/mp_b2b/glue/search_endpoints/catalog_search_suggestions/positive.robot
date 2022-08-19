*** Settings ***
Suite Setup    SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup

#GET requests
Get_search_suggestions_without_query_parameter
    When I send a GET request:    /catalog-search-suggestions
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response should contain the array of a certain size:    [data][0][attributes][completion]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categories]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPages]    0
    And Response should contain the array of a certain size:    [data][0][attributes][abstractProducts]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categoryCollection]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPageCollection]    0
    And Response body has correct self link

Get_search_suggestions_with_empty_q_parameter
    When I send a GET request:    /catalog-search-suggestions?q=
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response should contain the array of a certain size:    [data][0][attributes][completion]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categories]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPages]    0
    And Response should contain the array of a certain size:    [data][0][attributes][abstractProducts]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categoryCollection]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPageCollection]    0
    And Response body has correct self link

Get_search_suggestions_with_non_existing_product_sku
    When I send a GET request:    /catalog-search-suggestions?q=000000
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response should contain the array of a certain size:    [data][0][attributes][completion]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categories]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPages]    0
    And Response should contain the array of a certain size:    [data][0][attributes][abstractProducts]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categoryCollection]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPageCollection]    0
    And Response body has correct self link

Get_search_suggestions_with_discontinued_product_sku
    When I send a GET request:    /catalog-search-suggestions?q=${concrete_product_with_alternative.sku}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be:    [data][0][attributes][completion]    ${concrete_product_with_alternative.sku}
    And Response should contain the array of a certain size:    [data][0][attributes][categories]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPages]    0
    And Response body parameter should be greater than:    [data][0][attributes][abstractProducts][0][price]    0
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractName]    ${concrete_product_with_alternative.name}
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractSku]    ${abstract_product_with_alternative.sku}
    And Response body parameter should not be EMPTY:    [data][0][attributes][abstractProducts][0][url]
    And Response body parameter should not be EMPTY:    [data][0][attributes][abstractProducts][0][images]
    And Response should contain the array of a certain size:    [data][0][attributes][categoryCollection]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPageCollection]    0
    And Response body has correct self link

Get_search_suggestions_with_all_attributes_data
    When I send a GET request:    /catalog-search-suggestions?q=${concrete_product_with_alternative.name}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be:    [data][0][attributes][completion]    ${concrete_product_with_alternative.name_lower_case}
    And Each array element of array in response should contain property:    [data][0][attributes][categories]    name
    And Each array element of array in response should contain property:    [data][0][attributes][categories]    url
    And Each array element of array in response should contain property:    [data][0][attributes][cmsPages]    name
    And Each array element of array in response should contain property:    [data][0][attributes][cmsPages]    url
    And Response body parameter should be greater than:    [data][0][attributes][abstractProducts][0][abstractSku]    0
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractName]    ${concrete_product_with_alternative.name}
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractSku]    ${abstract_product_with_alternative.sku}
    And Response body parameter should be greater than:    [data][0][attributes][abstractProducts][1][abstractSku]    0
    And Response body parameter should be:    [data][0][attributes][abstractProducts][1][abstractSku]    ${alternative_abstract_product.sku}
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts]    price
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts]    abstractName
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts]    abstractSku
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts]    url
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts]    images
    And Each array element of array in response should contain property:    [data][0][attributes][categoryCollection]    name
    And Each array element of array in response should contain property:    [data][0][attributes][categoryCollection]    url
    And Each array element of array in response should contain property:    [data][0][attributes][cmsPageCollection]    name
    And Each array element of array in response should contain property:    [data][0][attributes][cmsPageCollection]    url
    And Response body has correct self link

Get_search_suggestions_with_few_symbols
    When I send a GET request:    /catalog-search-suggestions?q=soe
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response should contain the array of a certain size:    [data][0][attributes][completion]    10
    And Response should contain the array of a certain size:    [data][0][attributes][abstractProducts]    10
    And Each array element of array in response should contain value:    [data][0][attributes][completion]    soe
    And Each array element of array in response should contain value:    [data][0][attributes][abstractProducts]    soe
    And Response body has correct self link

Get_search_suggestions_with_abstract_product_sku
    When I send a GET request:    /catalog-search-suggestions?q=${abstract_available_product_with_stock.sku}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be greater than:    [data][0][attributes][abstractProducts][0][price]    0
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractName]    ${abstract_available_product_with_stock.name}
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractSku]    ${abstract_available_product_with_stock.sku}
    And Response body parameter should not be EMPTY:    [data][0][attributes][abstractProducts][0][url]
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts][0][images]    externalUrlSmall
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts][0][images]    externalUrlLarge
    And Response should contain the array of a certain size:    [data][0][attributes][completion]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categories]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPages]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categoryCollection]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPageCollection]    0
    And Response body has correct self link

Get_search_suggestions_with_concrete_product_sku
    When I send a GET request:    /catalog-search-suggestions?q=${concrete_product_with_alternative.sku}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be:    [data][0][attributes][completion]    ${concrete_product_with_alternative.sku}
    And Response body parameter should be greater than:    [data][0][attributes][abstractProducts][0][price]    0
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractName]    ${concrete_product_with_alternative.name}
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractSku]    ${abstract_product_with_alternative.sku}
    And Response body parameter should not be EMPTY:    [data][0][attributes][abstractProducts][0][url]
    And Response body parameter should not be EMPTY:    [data][0][attributes][abstractProducts][0][images]
    And Response should contain the array of a certain size:    [data][0][attributes][categories]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPages]    0
    And Response should contain the array of a certain size:    [data][0][attributes][categoryCollection]    0
    And Response should contain the array of a certain size:    [data][0][attributes][cmsPageCollection]    0
    And Response body has correct self link

Get_search_suggestions_with_cms_pages
    When I send a GET request:    /catalog-search-suggestions?q=${cms_pages.first_cms_page.name}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be:    [data][0][attributes][completion]    ${cms_pages.first_cms_page.name_in_lower_case}
    And Response body parameter should be:    [data][0][attributes][cmsPages][0][name]    ${cms_pages.first_cms_page.name}
    And Response body parameter should be:    [data][0][attributes][cmsPages][0][url]    ${cms_pages.first_cms_page.url_en}
    And Response body has correct self link

Get_search_suggestions_with_category_collection
    When I send a GET request:    /catalog-search-suggestions?q=${category_collection_name}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be:    [data][0][attributes][categoryCollection][0][name]    ${category_collection_name}
    And Response body parameter should be:    [data][0][attributes][categoryCollection][0][url]    ${category_collection_url}
    And Response body has correct self link

Get_search_suggestions_with_cms_page_collection
    When I send a GET request:    /catalog-search-suggestions?q=${cms_page_collection_name}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be:    [data][0][attributes][cmsPageCollection][0][name]    ${cms_page_collection_name}
    And Response body parameter should be:    [data][0][attributes][cmsPageCollection][0][url]    ${cms_page_collection_url}
    And Response body has correct self link

Get_search_suggestions_with_brand_and_currency
    When I send a GET request:    /catalog-search-suggestions?q=${brand_name}&currency=${currency.chf.code}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Each array element of array in response should contain value:    [data][0][attributes][completion]    ${brand_name}
    And Response should contain the array of a certain size:    [data][0][attributes][completion]    10
    And Response should contain the array of a certain size:    [data][0][attributes][abstractProducts]    10
    And Response body parameter should be:    [data][0][attributes][abstractProducts][8][price]    ${alternative_abstract_product.price_chf}
    And Response body has correct self link

Get_search_suggestions_with_color
    When I send a GET request:    /catalog-search-suggestions?q=${color_name}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Each array element of array in response should contain value:    [data][0][attributes][completion]    ${color_name}
    And Response should contain the array of a certain size:    [data][0][attributes][completion]    10
    And Response should contain the array of a certain size:    [data][0][attributes][abstractProducts]    10
    And Response body has correct self link

Get_search_suggestions_with_abstract_product_sku_and_included_abstract_products
    When I send a GET request:    /catalog-search-suggestions?q=${abstract_available_product_with_stock.sku}&include=abstract-products
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][0][type]    catalog-search-suggestions
    And Response body parameter should be:    [data][0][id]    None
    And Response body parameter should be greater than:    [data][0][attributes][abstractProducts][0][price]    0
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractName]    ${abstract_available_product_with_stock.name}
    And Response body parameter should be:    [data][0][attributes][abstractProducts][0][abstractSku]    ${abstract_available_product_with_stock.sku}
    And Response body parameter should not be EMPTY:    [data][0][attributes][abstractProducts][0][url]
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts][0][images]    externalUrlSmall
    And Each array element of array in response should contain property:    [data][0][attributes][abstractProducts][0][images]    externalUrlLarge
    And Response body parameter should be:    [data][0][relationships][abstract-products][data][0][type]    abstract-products
    And Response body parameter should be:    [data][0][relationships][abstract-products][data][0][id]    ${abstract_available_product_with_stock.sku}
    And Response body parameter should be:    [included][0][type]    abstract-products
    And Response body parameter should be:    [included][0][id]    ${abstract_available_product_with_stock.sku}
    And Response body parameter should be:    [included][0][attributes][sku]    ${abstract_available_product_with_stock.sku}
    And Response body parameter should be:    [included][0][attributes][averageRating]    None
    And Response body parameter should be:    [included][0][attributes][reviewCount]    0
    And Response body parameter should be:    [included][0][attributes][name]    ${abstract_available_product_with_stock.name}
    And Response body parameter should be:    [included][0][attributes][description]    ${abstract_available_product_with_stock.description}
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributes][norm]
    And Response body parameter should be:    [included][0][attributes][attributes][stapelbar]    No
    And Response body parameter should be:    [included][0][attributes][attributes][preiseinheit]    ${price_unit_1}
    And Response body parameter should be:    [included][0][attributes][attributes][reihenverbinder]    No
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributes][sitzschalenform]
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributes][rollenausfuehrung]
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributes][brand]
    And Response should contain the array of a certain size:    [included][0][attributes][superAttributesDefinition]    0
    And Response body parameter should contain:    [included][0][attributes][superAttributes][bezugsfarbe]    ${color_4}
    And Response body parameter should contain:    [included][0][attributes][attributeMap][super_attributes][bezugsfarbe]    ${color_4}
    And Response body parameter should contain:    [included][0][attributes][attributeMap][product_concrete_ids]    ${abstract_available_product_with_stock.concrete_available_product.sku}
    And Response should contain the array of a certain size:    [included][0][attributes][attributeMap][attribute_variants]    0
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributeMap][attribute_variant_map]
    And Response body parameter should contain:    [included][0][attributes]    metaTitle
    And Response body parameter should be:    [included][0][attributes][metaKeywords]    ${abstract_available_product_with_stock.concrete_available_product.meta_keywords}
    And Response body parameter should be:    [included][0][attributes][metaDescription]    ${abstract_available_product_with_stock.concrete_available_product.meta_description}
    And Response body parameter should not be EMPTY:    [included][0][attributes][attributeNames]
    And Response body parameter should not be EMPTY:    [included][0][attributes][url]
    And Response body has correct self link