*** Variables ***
${checkout_payment_invoice_date_of_birth_field}    id=paymentForm_dummyPaymentInvoice_date_of_birth
${checkout_payment_marketplace_invoice_date_field}    id=paymentForm_dummyMarketplacePaymentInvoice_dateOfBirth
${checkout_payment_card_number_field}    id=paymentForm_dummyPaymentCreditCard_card_number
${checkout_payment_name_on_card_field}    id=paymentForm_dummyPaymentCreditCard_name_on_card
${checkout_payment_card_expires_month_select}    id=paymentForm_dummyPaymentCreditCard_card_expires_month
${checkout_payment_card_expires_year_select}    id=paymentForm_dummyPaymentCreditCard_card_expires_year
${checkout_payment_card_security_code_field}    id=paymentForm_dummyPaymentCreditCard_card_security_code
&{checkout_payment_invoice_locator}    b2b=xpath=//input[@id='paymentForm_paymentSelection_0']