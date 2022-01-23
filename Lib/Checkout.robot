*** Settings ***
Library    SeleniumLibrary
Resource    ../Lib/Common_Utils.robot

Variables    ${EXECDIR}/Variables/webelement.yaml

Documentation    This resource file contains keywords for dealing with the checkout page

*** Keywords ***
Add Desktop And Proceed To Checkout As Guest
    Set Selenium Implicit Wait    15s
    Open Webui    ${browser}    ${url}digital-storm-vanquish-3-custom-performance-pc
    Page Should Contain    Digital Storm
    Click Button    //*[@id="add-to-cart-button-2"]
    Sleep    2
    Wait Until Keyword Succeeds    5 times    5 seconds
    ...    Click Link    //*[@id="topcartlink"]/a
    Page Should Contain    Shopping Cart
    Select Checkbox    //*[@id="termsofservice"]

    Click Button    //*[@id="checkout"]

    Click Button    class:checkout-as-guest-button
    Page Should Contain    Checkout
# --------------------------------------------
Select Same Shipping Address Checkbox
    Wait Until Element Is Visible    ${checkout}[billing_addr][ship_to_same_addr]    10s
    
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]
    IF    ${is_checked} == ${False}
        Select Checkbox    ${checkout}[billing_addr][ship_to_same_addr]
    END
    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]

Unselect Same Shipping Address Checkbox
    Wait Until Element Is Visible    ${checkout}[billing_addr][ship_to_same_addr]    10s
    
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]
    IF    ${is_checked} == ${True}
        Unselect Checkbox    ${checkout}[billing_addr][ship_to_same_addr]
    END

    Checkbox Should Not Be Selected   ${checkout}[billing_addr][ship_to_same_addr]

Input Address Form FirstName
    [Arguments]   ${addr_type}    ${firstName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[${addr_type}][firstname]  ${firstName}

Input Address Form LastName
    [Arguments]   ${addr_type}    ${lastName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[${addr_type}][lastname]  ${lastName}

Input Address Form Email
    [Arguments]    ${addr_type}    ${email}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[${addr_type}][email]  ${email}

Input Address Form Company
    [Arguments]    ${addr_type}    ${company}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][company]  ${company}

Select Address Form Country
    [Arguments]    ${addr_type}    ${country}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[${addr_type}][country]    ${country}

Select Address Form State
    [Arguments]    ${addr_type}    ${state}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[${addr_type}][state]    ${state}

Input Address Form City
    [Arguments]    ${addr_type}    ${city}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][city]  ${city}

Input Address Form Addr1
    [Arguments]    ${addr_type}    ${addr1}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][addr1]  ${addr1}

Input Address Form Addr2
    [Arguments]    ${addr_type}    ${addr2}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][addr2]  ${addr2}

Input Address Form Zip
    [Arguments]    ${addr_type}    ${zip}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][zip]  ${zip}

Input Address Form Phone
    [Arguments]    ${addr_type}    ${phone}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][phone]  ${phone}

Input Address Form Fax
    [Arguments]    ${addr_type}    ${fax}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][fax]  ${fax}

Fill Address Form
    [Arguments]    ${addr_type}
    ...            ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}
    ...            ${state}    ${company}=None    ${addr2}=None    ${fax}=None

    Input Address Form FirstName    ${addr_type}    ${firstName}
    Input Address Form LastName    ${addr_type}    ${lastName}
    Input Address Form Email    ${addr_type}    ${email}
    
    IF    "${company}" != "${None}"
        Input Address Form Company   ${addr_type}    ${company}        
    END
    
    Select Address Form Country    ${addr_type}    ${country}
    
    
    Select Address Form State    ${addr_type}    ${state}
    
    Input Address Form City    ${addr_type}    ${city}
    Input Address Form Addr1    ${addr_type}    ${addr1}
    
    IF    "${addr2}" != "${None}"
        Input Address Form Addr2    ${addr_type}    ${addr2}
    END

    Input Address Form Zip    ${addr_type}    ${zip}
    Input Address Form Phone    ${addr_type}    ${phone}

    IF    "${fax}" != "${None}"
        Input Address Form Fax    ${addr_type}    ${fax}
    END

Fill Billing Address Form
    [Arguments]    ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}
    ...            ${state}    ${company}=None    ${addr2}=None    ${fax}=None

    
    Fill Address Form    addr_type=billing_addr
    ...            firstName=${firstName}    lastName=${lastName}    email=${email}
    ...            country=${country}    city=${city}    addr1=${addr1}    zip=${zip}    phone=${phone}
    ...            state=${state}    company=${company}    addr2=${addr2}    fax=${fax}

Click Billing Address Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[billing_addr][continue_button]

# --------------------------------------------

Verify Shipping Address Form Is Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Be Visible    ${checkout}[shipping_addr][form]

Verify Shipping Address Form Is Not Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Not Be Visible    ${checkout}[shipping_addr][form]

Select Shipping Address As New Address
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Label    ${checkout}[shipping_addr][select_shipping_addr]    New Address

Fill Shipping Address Form
    [Arguments]    ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}
    ...            ${state}    ${company}=None    ${addr2}=None    ${fax}=None

    
    Fill Address Form    addr_type=shipping_addr
    ...            firstName=${firstName}    lastName=${lastName}    email=${email}
    ...            country=${country}    city=${city}    addr1=${addr1}    zip=${zip}    phone=${phone}
    ...            state=${state}    company=${company}    addr2=${addr2}    fax=${fax}

Click Shipping Address Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[shipping_addr][continue_button]
# --------------------------------------------
Verify Invalid Email Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Wrong email

Verify Is Required Message Appears
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    is required.

Verify Is Required Message Does Not Appear
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Not Contain    is required.
# --------------------------------------------

Verify Shipping Method Form Is Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Be Visible    ${checkout}[shipping_method][form]

Verify Shipping Method Form Is Not Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Not Be Visible    ${checkout}[shipping_method][form]

Choose Shipping Method As Ground
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[shipping_method][radio_shipping_method]    Ground___Shipping.FixedByWeightByTotal
    Radio Button Should Be Set To    ${checkout}[shipping_method][radio_shipping_method]    Ground___Shipping.FixedByWeightByTotal

Choose Shipping Method As Next Day Air
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[shipping_method][radio_shipping_method]    Next Day Air___Shipping.FixedByWeightByTotal
    Radio Button Should Be Set To    ${checkout}[shipping_method][radio_shipping_method]    Next Day Air___Shipping.FixedByWeightByTotal

Choose Shipping Method As Second Day Air
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[shipping_method][radio_shipping_method]    2nd Day Air___Shipping.FixedByWeightByTotal
    Radio Button Should Be Set To    ${checkout}[shipping_method][radio_shipping_method]    2nd Day Air___Shipping.FixedByWeightByTotal

Click Shipping Method Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[shipping_method][continue_button]
# --------------------------------------------
Verify Payment Method Form Is Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Be Visible    ${checkout}[payment_method][form]

Verify Payment Method Form Is Not Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Not Be Visible    ${checkout}[payment_method][form]

Choose Payment Method As Check Or Money Order
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[payment_method][radio_payment_method]    Payments.CheckMoneyOrder
    Radio Button Should Be Set To    ${checkout}[payment_method][radio_payment_method]    Payments.CheckMoneyOrder

Choose Payment Method As Credit Card
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[payment_method][radio_payment_method]    Payments.Manual
    Radio Button Should Be Set To    ${checkout}[payment_method][radio_payment_method]    Payments.Manual

Click Payment Method Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[payment_method][continue_button]
# --------------------------------------------
Verify Payment Information Form Is Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Be Visible    ${checkout}[payment_info][form]

Verify Payment Information Form Is Not Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Not Be Visible    ${checkout}[payment_info][form]
    
Verify Check Or Money Order Payment Information Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Mail Personal or Business Check, Cashier's Check or money order to:

Verify Credit Card Payment Information Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain     Select credit card:

Select Payment Information Credit Card
    [Arguments]    ${card}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[payment_info][credit_card]    ${card}

Input Payment Information Cardholder Name
    [Arguments]   ${name}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[payment_info][cardholder_name]    ${name}

Input Payment Information Card Number
    [Arguments]   ${cnum}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[payment_info][card_number]    ${cnum}

Input Payment Information Card Expiration Date
    [Arguments]    ${month}    ${year}
    
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[payment_info][expire_month]    ${month}
    
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[payment_info][expire_year]    ${year}

Input Payment Information Card Code
    [Arguments]   ${code}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[payment_info][card_code]    ${code}

Fill Payment Information Credit Card Form
    [Arguments]    ${card_type}    ${cardholder_name}    ${card_number}
    ...            ${expiration_month}    ${expiration_year}    ${card_code}

    Select Payment Information Credit Card    ${card_type}
    Input Payment Information Cardholder Name    ${cardholder_name}
    Input Payment Information Card Number    ${card_number}
    Input Payment Information Card Expiration Date    ${expiration_month}    ${expiration_year}
    Input Payment Information Card Code    ${card_code}

Verify Invalid Card Number Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Wrong card number

Verify Invalid Card Code Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Wrong card code

Click Payment Information Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[payment_info][continue_button]

# --------------------------------------------

Verify Confirm Order Form Is Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Be Visible    ${checkout}[confirm_order][form]

Verify Confirm Order Form Is Not Visible
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Element Should Not Be Visible    ${checkout}[confirm_order][form]

Click Confirm Order Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[confirm_order][confirm_order_button]

Verify Successful Checkout
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain   Thank you
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Your order has been successfully processed!

Verify Unsuccessful Checkout
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Not Contain   Thank you
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Not Contain    Your order has been successfully processed!
