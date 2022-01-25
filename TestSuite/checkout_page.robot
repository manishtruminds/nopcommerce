# Test Suite for Register page
*** Settings ***
Library    String
Library    Collections

Resource    ../Lib/Checkout.robot 
Resource    ../Lib/Common_Utils.robot

Variables    ${EXECDIR}/Variables/env.yaml
Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml

*** Variables ***
# Device test variables
${browser}    ${env_variables}[${ENV_TYPE}][browser]
${url}        ${env_variables}[${ENV_TYPE}][url]

*** Test Cases ***

Required Billing Address Fields
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test that billing address form requires required fields to be filled
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox

    # don't fill anything in the billing address form, just click on continue
    Click Billing Address Continue Button

    Verify Is Required Message Appears
    Verify Shipping Address Form Is Not Visible

    Close All Browsers


Optional Billing Address Fields
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test that billing address form doesn't require optional fields to be filled
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox
    
    # fill only required fields, leaving optional fields empty
    Fill Billing Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]

    Click Billing Address Continue Button

    Verify Is Required Message Does Not Appear
    Verify Shipping Address Form Is Visible

    Close All Browsers

Valid Billing Address Form
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test a Valid billing address form with all data filled
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox
    
    # fill all fields
    Fill Billing Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    addr2=${test_data}[checkout][addr2]
    ...    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    ...    company=${test_data}[checkout][company]    fax=${test_data}[checkout][fax]

    Click Billing Address Continue Button

    Verify Is Required Message Does Not Appear
    Verify Shipping Address Form Is Visible

    Close All Browsers

Invalid Billing Address Form With Invalid Email
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test an invalid billing address form with invalid emails
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox

    @{invalid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][invalid_emails]

    FOR    ${invalid_email}    IN    @{invalid_emails}
        Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${invalid_email}    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]

        Click Billing Address Continue Button
        Verify Invalid Email Message

        Verify Shipping Address Form Is Not Visible
    END
    
    Close All Browsers


Shipping Address Form Appears When Same Shipping Address Checkbox Is Unchecked
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test that the shipping address form appears when the same shipping address checkbox was unchecked
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox

    Fill Billing Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]

    Click Billing Address Continue Button

    Verify Shipping Address Form Is Visible

    Close All Browsers

Shipping Address Form Does Not Appear When Same Shipping Address Checkbox Is Checked
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test that the shipping address form does not appear when the same shipping address checkbox was checked
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Select Same Shipping Address Checkbox

    Fill Billing Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]

    Click Billing Address Continue Button

    Verify Shipping Address Form Is Not Visible

    Close All Browsers

#-----------------------
Required Shipping Address Fields
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test that shipping address form requires required fields to be filled
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Address Form Is Visible
    Select Shipping Address As New Address
    # don't fill anything in the new shipping address form, just click on continue
    Click Shipping Address Continue Button

    Verify Is Required Message Appears
    Verify Shipping Method Form Is Not Visible

    Close All Browsers


Optional Shipping Address Fields
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test that shipping address form doesn't require optional fields to be filled
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Address Form Is Visible
    Select Shipping Address As New Address

    # fill only required fields in the shipping address form, leaving optional fields empty
    Fill Shipping Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]

    Click Shipping Address Continue Button

    Verify Is Required Message Does Not Appear
    Verify Shipping Method Form Is Visible

    Close All Browsers

Valid Shipping Address Fields
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test a Valid shipping address form with all data filled
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Address Form Is Visible
    Select Shipping Address As New Address

    # fill all fields in the shipping address form
    Fill Shipping Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    addr2=${test_data}[checkout][addr2]
    ...    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    ...    company=${test_data}[checkout][company]    fax=${test_data}[checkout][fax]

    Click Shipping Address Continue Button

    Verify Is Required Message Does Not Appear
    Verify Shipping Method Form Is Visible

    Close All Browsers

Invalid Shipping Address Form With Invalid Email
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test an invalid shipping address form with invalid emails
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Unselect Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Address Form Is Visible
    Select Shipping Address As New Address

    @{invalid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][invalid_emails]

    FOR    ${invalid_email}    IN    @{invalid_emails}
        Fill Shipping Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${invalid_email}    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]

        Click Shipping Address Continue Button
        Verify Invalid Email Message

        Verify Shipping Method Form Is Not Visible
    END
    
    Close All Browsers
#-----------------------


Valid Checkout With Ground Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test a valid checkout with shipping method as "Ground" and payment method as "Check or Money Order" 
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Select Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Method Form Is Visible
    Choose Shipping Method As Ground
    Click Shipping Method Continue Button

    Verify Payment Method Form Is Visible
    Choose Payment Method As Check Or Money Order
    Click Payment Method Continue Button

    Verify Payment Information Form Is Visible
    Verify Check Or Money Order Payment Information Message
    Click Payment Information Continue Button

    Verify Confirm Order Form Is Visible
    Click Confirm Order Button

    Verify Successful Checkout

    Close All Browsers


Invalid Checkout With Ground Shipping And Credit Card Payment
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test an invalid checkout with shipping method as "Ground" and payment method as "Credit Card"
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Select Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Method Form Is Visible
    Choose Shipping Method As Ground
    Click Shipping Method Continue Button

    Verify Payment Method Form Is Visible
    Choose Payment Method As Credit Card
    Click Payment Method Continue Button

    Verify Payment Information Form Is Visible
    Verify Credit Card Payment Information Message
    Fill Payment Information Credit Card Form
    ...    card_type=${test_data}[checkout][card_type]    cardholder_name=${test_data}[checkout][cardholder_name]
    ...    card_number=${test_data}[checkout][card_number]    expiration_month=${test_data}[checkout][expiration_month]
    ...    expiration_year=${test_data}[checkout][expiration_year]    card_code=${test_data}[checkout][card_code]
    Click Payment Information Continue Button

    Verify Invalid Card Number Message
    Verify Confirm Order Form Is Not Visible

    Verify Unsuccessful Checkout

    Close All Browsers

Valid Checkout With Next Day Air Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test a valid checkout with shipping method as "Next Day Air" and payment method as "Check or Money Order"
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Select Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Method Form Is Visible
    Choose Shipping Method As Next Day Air
    Click Shipping Method Continue Button

    Verify Payment Method Form Is Visible
    Choose Payment Method As Check Or Money Order
    Click Payment Method Continue Button

    Verify Payment Information Form Is Visible
    Verify Check Or Money Order Payment Information Message
    Click Payment Information Continue Button

    Verify Confirm Order Form Is Visible
    Click Confirm Order Button

    Verify Successful Checkout

    Close All Browsers

Invalid Checkout With Next Day Air Shipping And Credit Card Payment
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test an invalid checkout with shipping method as "Next Day Air" and payment method as "Credit Card"
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Select Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Method Form Is Visible
    Choose Shipping Method As Next Day Air
    Click Shipping Method Continue Button

    Verify Payment Method Form Is Visible
    Choose Payment Method As Credit Card
    Click Payment Method Continue Button

    Verify Payment Information Form Is Visible
    Verify Credit Card Payment Information Message
    Fill Payment Information Credit Card Form
    ...    card_type=${test_data}[checkout][card_type]    cardholder_name=${test_data}[checkout][cardholder_name]    card_number=${test_data}[checkout][card_number]
    ...    expiration_month=${test_data}[checkout][expiration_month]    expiration_year=${test_data}[checkout][expiration_year]    card_code=${test_data}[checkout][card_code]
    Click Payment Information Continue Button

    Verify Invalid Card Number Message
    Verify Confirm Order Form Is Not Visible

    Verify Unsuccessful Checkout

    Close All Browsers

Valid Checkout With Second Day Air Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test a valid checkout with shipping method as "Second Day Air" and payment method as "Check Or Money Order"
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Select Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Method Form Is Visible
    Choose Shipping Method As Second Day Air
    Click Shipping Method Continue Button

    Verify Payment Method Form Is Visible
    Choose Payment Method As Check Or Money Order
    Click Payment Method Continue Button

    Verify Payment Information Form Is Visible
    Verify Check Or Money Order Payment Information Message
    Click Payment Information Continue Button

    Verify Confirm Order Form Is Visible
    Click Confirm Order Button

    Verify Successful Checkout

    Close All Browsers

Invalid Checkout With Second Day Air Shipping And Credit Card Payment
    [Tags]    WebUI    WebUI_Checkout
    [Documentation]    Test an invalid checkout with shipping method as "Second Day Air" and payment method as "Credit Card"
    
    Add Nike Floral Shoes To Cart And Checkout As Guest
    Select Same Shipping Address Checkbox

    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    
    Click Billing Address Continue Button
    
    Verify Shipping Method Form Is Visible
    Choose Shipping Method As Second Day Air
    Click Shipping Method Continue Button

    Verify Payment Method Form Is Visible
    Choose Payment Method As Credit Card
    Click Payment Method Continue Button

    Verify Payment Information Form Is Visible
    Verify Credit Card Payment Information Message
    Fill Payment Information Credit Card Form
    ...    card_type=${test_data}[checkout][card_type]    cardholder_name=${test_data}[checkout][cardholder_name]    card_number=${test_data}[checkout][card_number]
    ...    expiration_month=${test_data}[checkout][expiration_month]    expiration_year=${test_data}[checkout][expiration_year]    card_code=${test_data}[checkout][card_code]
    Click Payment Information Continue Button

    Verify Invalid Card Number Message
    Verify Confirm Order Form Is Not Visible

    Verify Unsuccessful Checkout

    Close All Browsers
