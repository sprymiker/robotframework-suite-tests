*** Settings ***
Resource    ../common/common.robot
Resource    ../pages/yves/yves_catalog_page.robot
Resource    ../steps/shopping_carts_steps.robot

*** Variable ***
${priceModeSwitcher}    ${price_mode_switcher_header_menu_item}
${currencySwitcher}    ${currency_switcher_header_menu_item}
${languageSwitcher}    ${language_switcher_header_menu_item}
${quickOrderIcon}    ${quick_order_icon_header_menu_item}
${accountIcon}    ${user_navigation_icon_header_menu_item}
${shoppingListIcon}    ${shopping_list_icon_header_menu_item}
${shoppingCartIcon}    ${shopping_car_icon_header_menu_item}
${customerSearchWidget}    ${agent_customer_search_widget}  
${quoteRequestsWidget}    ${agent_quote_requests_header_item}
${wishlistIcon}    ${wishlist_icon_header_navigation_widget}

*** Keywords ***   
Yves: perform search by:
    [Arguments]    ${searchTerm}
    Run keyword if    '${env}'=='b2c'    Click    xpath=//div[@class='header__search-open js-suggest-search__show']
    wait until element is visible    ${search_form_header_menu_item}
    Type Text    ${search_form_header_menu_item}    ${searchTerm}
    Keyboard Key    press    Enter
    Wait Until Page Contains Element    ${catalog_main_page_locator}

Yves: header contains/doesn't contain: 
    [Arguments]    ${condition}    @{header_elements_list}    ${element1}=${EMPTY}     ${element2}=${EMPTY}     ${element3}=${EMPTY}     ${element4}=${EMPTY}     ${element5}=${EMPTY}     ${element6}=${EMPTY}     ${element7}=${EMPTY}     ${element8}=${EMPTY}     ${element9}=${EMPTY}     ${element10}=${EMPTY}     ${element11}=${EMPTY}     ${element12}=${EMPTY}     ${element13}=${EMPTY}     ${element14}=${EMPTY}     ${element15}=${EMPTY}
    ${header_elements_list_count}=   get length  ${header_elements_list}
    FOR    ${index}    IN RANGE    0    ${header_elements_list_count}
        ${header_element_to_check}=    Get From List    ${header_elements_list}    ${index}
        IF    '${condition}' == 'true'    
        ...    Run Keywords
        ...    Log    ${header_element_to_check}    #Left as an example of multiple actions in Condition
        ...    AND    Page Should Contain Element    ${header_element_to_check}    message=${header_element_to_check} is not displayed
        IF    '${condition}' == 'false'    
        ...    Run Keywords
        ...    Log    ${header_element_to_check}    #Left as an example of multiple actions in Condition
        ...    AND    Page Should Not Contain Element    ${header_element_to_check}    message=${header_element_to_check} should not be displayed
    END