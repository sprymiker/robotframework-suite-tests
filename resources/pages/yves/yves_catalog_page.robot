*** Variable ***
${catalog_main_page_locator}    xpath=//div[contains(@class,'catalog-right')]
${catalog_product_card_locator}    xpath=//product-item[@data-qa='component product-item'][1]//a[contains(@class,'link-detail-page') and (contains(@class,'info')) or (contains(@class,'name'))]
${catalog_products_counter_locator}    xpath=//*[contains(@class,'sort__results col')]
${catalog_filter_apply_button}    xpath=//section[@data-qa='component filter-section']//button[contains(@class,'button')]
${catalog_add_to_cart_button}    xpath=//button[contains(@title,'Add to Cart')]