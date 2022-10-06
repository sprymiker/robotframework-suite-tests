*** Variables ***
${checkout_address_billing_same_as_shipping_checkbox}    id=addressesForm_billingSameAsShipping
&{checkout_address_delivery_dropdown}    b2b=xpath=//span[@id='select2-checkout-full-addresses-ct-container']    b2c=xpath=//span[@id='select2-addressesForm_shippingAddress_id_customer_address-container']    mp_b2b=xpath=//span[@id='select2-checkout-full-addresses-ct-container']
&{checkout_address_delivery_selector}    b2c=xpath=//select[@id='addressesForm_shippingAddress_id_customer_address']    b2b=xpath=//div[contains(@class,'shippingAddress')]//select[@name='checkout-full-addresses'][contains(@class,'address__form')]    suite-nonsplit=xpath=//div[contains(@class,'shippingAddress')]//select[@name='checkout-full-addresses'][contains(@class,'address__form')]    mp_b2b=xpath=//div[contains(@class,'shippingAddress')]//select[@name='checkout-full-addresses'][contains(@class,'address__form')]
${checkout_shipping_address_item_form}    xpath=//div[@data-qa='component address-item-form']
${checkout_new_billing_address_form}    xpath=//div[contains(@class,'address__billing')][@data-qa='component form']
${checkout_new_shipping_address_form}    xpath=//div[contains(@class,'address__shipping')][@data-qa='component form']
&{checkout_shipping_address_first_name_field}    b2b=id=checkout_shipping_address_first_name_field    b2c=id=addressesForm_shippingAddress_first_name    suite-nonsplit=id=addressesForm_shippingAddress_first_name    mp_b2b=id=checkout_shipping_address_first_name_field
${checkout_shipping_address_last_name_field}    id=addressesForm_shippingAddress_last_name
${checkout_shipping_address_company_name_field}    id=addressesForm_shippingAddress_company
${checkout_shipping_address_street_field}    id=addressesForm_shippingAddress_address1
${checkout_shipping_address_house_number_field}    id=addressesForm_shippingAddress_address2
${checkout_shipping_address_additional_address_field}    id=addressesForm_shippingAddress_address3
${checkout_shipping_address_zip_code_field}    id=addressesForm_shippingAddress_zip_code
${checkout_shipping_address_city_field}    id=addressesForm_shippingAddress_city
${checkout_shipping_address_phone_field}    id=addressesForm_shippingAddress_phone
${checkout_shipping_address_salutation_selector}    id=addressesForm_shippingAddress_salutation
${checkout_shipping_address_country_selector}    id=addressesForm_shippingAddress_iso2_code
${checkout_address_submit_button}    xpath=//button[@data-qa='submit-button']
&{checkout_address_billing_selector}    b2c=xpath=//select[@id='addressesForm_billingAddress_id_customer_address']    b2b=xpath=//select[contains(@class,'form-select-billingAddress')]    mp_b2b=xpath=//select[contains(@class,'form-select-billingAddress')]
${checkout_billing_address_salutation_selector}    xpath=//select[@id='addressesForm_billingAddress_salutation']
${checkout_billing_address_first_name_field}    id=addressesForm_billingAddress_first_name
${checkout_billing_address_last_name_field}    id=addressesForm_billingAddress_last_name
${checkout_billing_address_company_name_field}    id=addressesForm_billingAddress_company
${checkout_billing_address_street_field}    id=addressesForm_billingAddress_address1
${checkout_billing_address_house_number_field}    id=addressesForm_billingAddress_address2
${checkout_billing_address_additional_address_field}    id=addressesForm_billingAddress_address3
${checkout_billing_address_zip_code_field}    id=addressesForm_billingAddress_zip_code
${checkout_billing_address_city_field}    id=addressesForm_billingAddress_city
${checkout_billing_address_country_select}    id=addressesForm_billingAddress_iso2_code
${checkout_billing_address_phone_field}    id=addressesForm_billingAddress_phone
${manage_your_addresses_link}    xpath=//a[contains(@href,'customer/address')]
&{billing_address_section}    b2b=xpath=//form[@name='addressesForm']//div[contains(@class,'billing-same-as-shipping')]    b2c=xpath=//form[@name='addressesForm']//div[contains(@class,'billing-address')]    suite-nonsplit=xpath=//form[@name='addressesForm']//div[contains(@class,'billing-same-as-shipping')]    mp_b2b=xpath=//form[@name='addressesForm']//div[contains(@class,'billing-same-as-shipping')]