*** Settings ***
Library    BuiltIn
Resource    common.robot
Resource    ../pages/mp/mp_login_page.robot

*** Variable ***
${mp_user_menu_icon}   xpath=//button[@class='spy-user-menu__action']
${mp_search_field_locator}     xpath=//input[@type='search']
${mp_table_locator}    xpath=//table/tbody

*** Keywords ***
MP: login on MP with provided credentials:
    [Arguments]    ${email}    ${password}=${default_password}
    go to    ${mp_url}
    delete all cookies
    Reload    
    Wait Until Element Is Visible    ${mp_user_name_field}
    Type Text    ${mp_user_name_field}    ${email}
    Type Text    ${mp_password_field}    ${password}
    Click    ${mp_login_button}
    Wait Until Element Is Visible    ${mp_user_menu_icon}    Zed:Dashboard page is not displayed

MP: go to first navigation item level:
    [Documentation]     example: "MP: go to first navigation item level:  Orders"
    [Arguments]     ${navigation_item}
    ${navigation_item}=    Convert To Lower Case    ${navigation_item}
    Click    xpath=//spy-navigation[@class='spy-navigation']//li//a[contains(@href,'${navigation_item}')]
