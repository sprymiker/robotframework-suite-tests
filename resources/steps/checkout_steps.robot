*** Settings ***
Resource    ../pages/yves/yves_checkout_address_page.robot
Resource    ../pages/yves/yves_checkout_login_page.robot
Resource    ../pages/yves/yves_checkout_payment_page.robot
Resource    ../pages/yves/yves_checkout_summary_page.robot
Resource    ../common/common_yves.robot


*** Variables ***
${submit_checkout_form_button}    xpath=//div[contains(@class,'form--checkout-form')]//button[@data-qa='submit-button']

*** Keywords ***
Yves: billing address same as shipping address:
    [Arguments]    ${state}
    Run keyword if    '${env}'=='b2b'    Wait Until Page Contains Element    ${manage_your_addresses_link}
    ${checkboxState}=    Set Variable    ${EMPTY}
    ${checkboxState}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//input[@id='addressesForm_billingSameAsShipping'][@checked]
    Run Keyword If    '${checkboxState}'=='False' and '${state}' == 'true'    Click Element by xpath with JavaScript    //input[@id='addressesForm_billingSameAsShipping']
    Run Keyword If    '${checkboxState}'=='True' and '${state}' == 'false'    Click Element by xpath with JavaScript    //input[@id='addressesForm_billingSameAsShipping']

Yves: accept the terms and conditions:
    [Documentation]    ${state} can be true or false
    [Arguments]    ${state}    ${isGuest}=false
    IF    '${state}' == 'true' and '${isGuest}'=='false'    Run keywords    Wait Until Page Contains Element    xpath=//input[@name='acceptTermsAndConditions']    AND    Run Keyword And Ignore Error    Click Element by xpath with JavaScript    //input[@name='acceptTermsAndConditions']
    ...    ELSE    Run Keyword If    '${state}'=='true' and '${isGuest}'=='true'    Run keywords    Wait Until Page Contains Element    id=guestForm_customer_accept_terms    AND    Click Element by id with JavaScript    guestForm_customer_accept_terms

Yves: fill in the following new shipping address:
    [Documentation]    Possible argument names: salutation, firstName, lastName, street, houseNumber, postCode, city, country, company, phone, additionalAddress
    [Arguments]    @{args}
    ${newAddressData}=    Set Up Keyword Arguments    @{args}
    Select From List By Label    ${checkout_address_delivery_selector}    Define new address
    Wait Until Element Is Visible    ${checkout_new_shipping_address_form}
    FOR    ${key}    ${value}    IN    &{newAddressData}
        Log    Key is '${key}' and value is '${value}'.
        Run keyword if    '${key}'=='salutation' and '${value}' != '${EMPTY}'    Select From List By Label    ${checkout_shipping_address_salutation_selector}    ${value}
        Run keyword if    '${key}'=='firstName' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_first_name_field}    ${value}
        Run keyword if    '${key}'=='lastName' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_last_name_field}    ${value}
        Run keyword if    '${key}'=='street' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_street_field}    ${value}
        Run keyword if    '${key}'=='houseNumber' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_house_number_field}    ${value}
        Run keyword if    '${key}'=='postCode' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_zip_code_field}    ${value}
        Run keyword if    '${key}'=='city' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_city_field}    ${value}
        Run keyword if    '${key}'=='country' and '${value}' != '${EMPTY}'    Select From List By Label    ${checkout_shipping_address_country_selector}    ${value}
        Run keyword if    '${key}'=='company' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_company_name_field}    ${value}
        Run keyword if    '${key}'=='phone' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_phone_field}    ${value}
        Run keyword if    '${key}'=='additionalAddress' and '${value}' != '${EMPTY}'    Type Text    ${checkout_shipping_address_additional_address_field}    ${value}
    END

Yves: select the following shipping method on the checkout and go next:
    [Arguments]    ${shippingMethod}
    Click    xpath=//div[@data-qa='component shipment-sidebar']//*[contains(.,'Shipping Method')]/../ul//label[contains(.,'${shippingMethod}')]/span[contains(@class,'radio__box')]
    Click    ${submit_checkout_form_button}

Yves: submit form on the checkout
    Click    ${submit_checkout_form_button}

Yves: select the following payment method on the checkout and go next:
    [Arguments]    ${paymentMethod}    ${paymentProvider}=${EMPTY}
    Click    xpath=//form[@name='paymentForm']//span[contains(@class,'toggler') and contains(text(),'${paymentMethod}')]/preceding-sibling::span[@class='toggler-radio__box']
    Type Text    ${checkout_payment_invoice_date_of_birth_field}    11.11.1111
    Click    ${submit_checkout_form_button}

Yves: '${checkoutAction}' on the summary page
    [Documentation]    Possible supported actions: 'submit the order', 'send the request' and 'approve the cart'
    Run Keyword If    '${checkoutAction}' == 'submit the order'    Click    ${checkout_summary_submit_order_button}
    ...    ELSE IF    '${checkoutAction}' == 'send the request'    Click    ${checkout_summary_send_request_button}
    ...    ELSE IF    '${checkoutAction}' == 'approve the cart'    Click    ${checkout_summary_approve_request_button}

Yves: proceed with checkout as guest:
    [Arguments]    ${salutation}    ${firstName}    ${lastName}    ${email}
    Wait Until Page Contains Element    xpath=//span[contains(text(),'Buy as Guest')]/ancestor::label[@class='toggler-radio__container']/input
    Click Element by xpath with JavaScript    //span[contains(text(),'Buy as Guest')]/ancestor::label[@class='toggler-radio__container']/input
    Wait Until Element Is Visible    ${yves_checkout_login_guest_firstName_field}
    Type Text    ${yves_checkout_login_guest_firstName_field}     ${firstName}
    Type Text    ${yves_checkout_login_guest_lastName_field}     ${lastName}
    Type Text    ${yves_checkout_login_guest_email_field}     ${email}
    Yves: accept the terms and conditions:    true    true
    Click    ${yves_checkout_login_buy_as_guest_submit_button}