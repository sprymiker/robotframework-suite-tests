*** Settings ***
Suite Setup    SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***


Retrieves_list_of_merchants
    When I send a GET request:  /merchants
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Each array element of array in response should contain property:    [data]    type
    And Each array element of array in response should contain property:    [data]    id
    And Each array element of array in response should contain property:    [data]    attributes
    And Each array element of array in response should contain property with value:    [data]    type    merchants
    And Each array element of array in response should contain nested property:    [data]    [attributes]    merchantName
    And Each array element of array in response should contain nested property:    [data]    [attributes]    merchantUrl
    And Each array element of array in response should contain nested property:    [data]    [attributes]    contactPersonRole
    And Each array element of array in response should contain nested property:    [data]    [attributes]    contactPersonTitle
    And Each array element of array in response should contain nested property:    [data]    [attributes]    contactPersonFirstName
    And Each array element of array in response should contain nested property:    [data]    [attributes]    contactPersonLastName
    And Each array element of array in response should contain nested property:    [data]    [attributes]    contactPersonPhone
    And Each array element of array in response should contain nested property:    [data]    [attributes]    logoUrl
    And Each array element of array in response should contain nested property:    [data]    [attributes]    publicEmail
    And Each array element of array in response should contain nested property:    [data]    [attributes]    publicPhone
    And Each array element of array in response should contain nested property:    [data]    [attributes]    description
    And Each array element of array in response should contain nested property:    [data]    [attributes]    bannerUrl
    And Each array element of array in response should contain nested property:    [data]    [attributes]    deliveryTime
    And Each array element of array in response should contain nested property:    [data]    [attributes]    faxNumber
    And Each array element of array in response should contain nested property:    [data]    [attributes][legalInformation]    terms
    And Each array element of array in response should contain nested property:    [data]    [attributes][legalInformation]    cancellationPolicy
    And Each array element of array in response should contain nested property:    [data]    [attributes][legalInformation]    imprint
    And Each array element of array in response should contain nested property:    [data]    [attributes][legalInformation]    dataPrivacy
    And Each array element of array in response should contain nested property:    [data]    [attributes]    categories
    And Each array element of array in response should contain nested property:    [data]    [links]    self



Retrieves_a_merchant_by_id
    When I send a GET request:  /merchants/${merchant_id}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should not be EMPTY:    [data][type]
    And Response body parameter should not be EMPTY:    [data][id]    
    And Response body parameter should be:    [data][id]    ${merchant_id}
    And Response body parameter should be:    [data][type]    merchants
    And Response body parameter should not be EMPTY:    [data][attributes]
    And Response body parameter should not be EMPTY:    [data][attributes][merchantName]
    And Response body parameter should not be EMPTY:    [data][attributes][merchantUrl]
    And Response body parameter should not be EMPTY:    [data][attributes][contactPersonRole]
    And Response body parameter should not be EMPTY:    [data][attributes][contactPersonTitle]
    And Response body parameter should not be EMPTY:    [data][attributes][contactPersonFirstName]
    And Response body parameter should not be EMPTY:    [data][attributes][contactPersonLastName]
    And Response body parameter should not be EMPTY:    [data][attributes][contactPersonPhone]
    And Response body parameter should not be EMPTY:    [data][attributes][logoUrl]
    And Response body parameter should not be EMPTY:    [data][attributes][publicEmail]
    And Response body parameter should not be EMPTY:    [data][attributes][publicPhone]
    And Response body parameter should not be EMPTY:    [data][attributes][description]
    And Response body parameter should not be EMPTY:    [data][attributes][bannerUrl]
    And Response body parameter should not be EMPTY:    [data][attributes][deliveryTime]
    And Response body parameter should not be EMPTY:    [data][attributes][faxNumber]
    And Response body parameter should not be EMPTY:    [data][attributes][legalInformation][terms]
    And Response body parameter should not be EMPTY:    [data][attributes][legalInformation][cancellationPolicy]
    And Response body parameter should not be EMPTY:    [data][attributes][legalInformation][imprint]
    And Response body parameter should not be EMPTY:    [data][attributes][legalInformation][dataPrivacy]
    And Response body parameter should not be EMPTY:    [data][links][self]
    And Response body parameter should have datatype:    [data][attributes][categories]    list