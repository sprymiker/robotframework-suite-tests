*** Settings ***
Resource    ../common/common.robot
Resource    ../pages/yves/yves_product_details_page.robot
Resource    ../common/common_yves.robot

*** Variable ***
${pdpPriceLocator}    ${pdp_price_element_locator}
${addToCartButton}    ${pdp_add_to_cart_button}

*** Keywords ***
Yves: add product to the shopping cart
    Click    ${pdp_add_to_cart_button}
    Yves: remove flash messages

Yves: add product to wishlist:
    [Arguments]    ${wishlistName}    ${selectWishlist}=
    Wait Until Element Is Visible    ${pdp_add_to_wishlist_button}
    Wait Until Element Is Enabled    ${pdp_add_to_wishlist_button}
    ${wishlistSelectorExists}=    Run Keyword And Return Status    Element Should Be Visible    ${pdp_wishlist_dropdown}
    Run Keyword If    '${selectWishlist}'=='select'    Run keywords
    ...    Wait Until Element Is Visible    xpath=//select[contains(@name,'wishlist-name')]
    ...    AND    Wait Until Element Is Enabled    xpath=//select[contains(@name,'wishlist-name')]
    ...    AND    Select From List By Value    xpath=//select[contains(@name,'wishlist-name')]    ${wishlistName}      
    Click    ${pdp_add_to_wishlist_button}
    Yves: flash message should be shown:    success    Items added successfully
    Yves: remove flash messages