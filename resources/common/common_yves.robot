*** Settings ***
Library    String
Library    Browser
Resource    common.robot
Resource    ../pages/yves/yves_catalog_page.robot
Resource    ../pages/yves/yves_product_details_page.robot
Resource    ../pages/yves/yves_shopping_carts_page.robot
Resource    ../pages/yves/yves_shopping_cart_page.robot
Resource    ../pages/yves/yves_checkout_success_page.robot
Resource    ../pages/yves/yves_customer_account_page.robot
Resource    ../pages/yves/yves_checkout_summary_page.robot
Resource    ../steps/header_steps.robot

*** Variable ***
${notification_area}    xpath=//section[@data-qa='component notification-area']


*** Keywords ***
Yves: login on Yves with provided credentials:
    [Arguments]    ${email}    ${password}=${default_password}
    ${currentURL}=    Get Url
    IF    '/login' in '${currentURL}'    Run keywords
    ...    Type Text    ${email_field}    ${email}
    ...    AND    Type Text    ${password_field}    ${password}
    ...    AND    Click    ${form_login_button}
    ...    ELSE    Run Keywords
    ...    Go To    ${host}
    ...    AND    delete all cookies
    ...    AND    Reload
    ...    AND    mouse over  ${user_navigation_icon_header_menu_item}
    ...    AND    Wait Until Element Is Visible    ${user_navigation_menu_login_button}
    ...    AND    Click    ${user_navigation_menu_login_button}
    ...    AND    Wait Until Element Is Visible    ${email_field}
    ...    AND    Type Text    ${email_field}    ${email}
    ...    AND    Type Text    ${password_field}    ${password}
    ...    AND    Click    ${form_login_button}
    IF    'fake' not in '${email}' or 'agent' in '${email}'  Wait Until Element Is Visible    ${user_navigation_icon_header_menu_item}     Login Failed!
    Run Keyword If    'agent' in '${email}'    Yves: header contains/doesn't contain:    true    ${customerSearchWidget}
    Yves: remove flash messages

Yves: go to PDP of the product with sku:
    [Arguments]    ${sku}
    Yves: perform search by:    ${sku}
    Wait Until Page Contains Element    ${catalog_product_card_locator}
    Click    ${catalog_product_card_locator}
    Wait Until Page Contains Element    ${pdp_main_container_locator}

Yves: '${pageName}' page is displayed
    IF    '${pageName}' == 'Thank you'    Page Should Contain Element    ${success_page_main_container_locator}    ${pageName} page is not displayed

Yves: remove flash messages
    ${flash_massage_state}=    Run Keyword And Ignore Error    Page Should Contain Element    ${notification_area}    1s
    Log    ${flash_massage_state}
    Run Keyword If    'PASS' in ${flash_massage_state}     Remove element from HTML with JavaScript    //section[@data-qa='component notification-area']

Yves: flash message '${condition}' be shown
   Run Keyword If    '${condition}' == 'should'    Wait Until Element Is Visible    ${notification_area}
    ...    ELSE    Page Should Not Contain Element    ${notification_area}

Yves: flash message should be shown:
    [Documentation]    ${type} can be: error, success
    [Arguments]    ${type}    ${text}
    Run Keyword If    '${type}' == 'error'    Element Should Be Visible    xpath=//flash-message[contains(@class,'alert')]//div[contains(text(),'${text}')]
    ...    ELSE    Run Keyword If    '${type}' == 'success'    Element Should Be Visible    xpath=//flash-message[contains(@class,'success')]//div[contains(text(),'${text}')]

Yves: go to the 'Home' page
    Go To    ${host}
Yves: go to URL:
    [Arguments]    ${url}
    Go To    ${host}${url}

Yves: check if cart is not empty and clear it
    Yves: go to the 'Home' page
    Yves: go to b2c shopping cart
    ${productsInCart}=    Get Element Count    xpath=//article[@class='product-card-item']//div[contains(@class,'product-card-item__box')]
    ${cartIsEmpty}=    Run Keyword And Return Status    Element should be visible    xpath=//*[contains(@class,'spacing-top') and text()='Your shopping cart is empty!']
    Run Keyword If    '${cartIsEmpty}'=='False'    Helper: delete all items in cart

Helper: delete all items in cart
    ${productsInCart}=    Get Element Count    xpath=//article[@class='product-card-item']//div[contains(@class,'product-card-item__box')]
    FOR    ${index}    IN RANGE    0    ${productsInCart}
        Click    xpath=(//div[@class='page-layout-cart__items-wrap']//ancestor::div/following-sibling::div//form[contains(@name,'removeFromCart')]//button[text()='Remove'])\[1\]
        Yves: remove flash messages
    END

Yves: get current lang
    ${lang}=    get attribute    xpath=//html    lang
    return from keyword   ${lang}
