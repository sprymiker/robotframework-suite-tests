*** Settings ***
Resource    ../pages/yves/yves_shopping_carts_page.robot
Resource    ../pages/yves/yves_shopping_cart_page.robot
Resource    ../common/common_yves.robot

*** Variables ***

*** Keywords ***   
Yves: go to b2c shopping cart
    Wait Until Element Is Visible    ${shopping_car_icon_header_menu_item}
    Click     ${shopping_car_icon_header_menu_item}
    Wait Until Element Is Visible    ${shopping_cart_main_content_locator}
             
Yves: click on the '${buttonName}' button in the shopping cart
    Yves: remove flash messages
    Run Keyword If    '${buttonName}' == 'Checkout'    Click    ${shopping_cart_checkout_button}
    ...    ELSE IF    '${buttonName}' == 'Request a Quote'    Click    ${shopping_cart_request_quote_button}
