*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/Variables/webelement.yaml

Documentation    This resource file contains keywords for dealing with the checkout page

*** Keywords ***
Add Desktop And Proceed To Checkout As Guest
    Set Selenium Implicit Wait    15s
    Open Webui    ${browser}    ${url}digital-storm-vanquish-3-custom-performance-pc
    Page Should Contain    Digital Storm
    Click Button    //*[@id="add-to-cart-button-2"]
    Sleep    5
    Click Link    //*[@id="topcartlink"]/a
    Page Should Contain    Shopping Cart
    Select Checkbox    //*[@id="termsofservice"]

    Click Button    //*[@id="checkout"]

    Click Button    class:checkout-as-guest-button

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
#####
Input Billing Address FirstName
    [Arguments]   ${firstName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[billing_addr][firstname]  ${firstName}

Input Billing Address LastName
    [Arguments]   ${lastName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[billing_addr][lastname]  ${lastName}

Input Billing Address Email
    [Arguments]    ${email}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[billing_addr][email]  ${email}

Input Billing Address Company
    [Arguments]    ${company}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][company]  ${company}

Select Billing Address Country
    [Arguments]    ${country}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[billing_addr][country]    ${country}

Select Billing Address State
    [Arguments]    ${state}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[billing_addr][state]    ${state}

Input Billing Address City
    [Arguments]    ${city}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][city]  ${city}

Input Billing Address Addr1
    [Arguments]    ${addr1}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][addr1]  ${addr1}

Input Billing Address Addr2
    [Arguments]    ${addr2}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][addr2]  ${addr2}

Input Billing Address Zip
    [Arguments]    ${zip}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][zip]  ${zip}

Input Billing Address Phone
    [Arguments]    ${phone}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][phone]  ${phone}

Input Billing Address Fax
    [Arguments]    ${fax}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][fax]  ${fax}

Click Billing Address Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[billing_addr][continue_button]

Fill Billing Address Form
    [Arguments]    ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}
    ...            ${state}=0    ${company}=None    ${addr2}=None    ${fax}=None

    Input Billing Address FirstName    ${firstName}
    Input Billing Address LastName    ${lastName}
    Input Billing Address Email    ${email}
    
    IF    "${company}" != "${None}"
        Input Billing Address Company   ${company}        
    END
    
    Select Billing Address Country    ${country}
    
    IF    ${state} != 0
        Select Billing Address State    ${state}
    END
    
    Input Billing Address City    ${city}
    Input Billing Address Addr1    ${addr1}
    
    IF    "${addr2}" != "${None}"
        Input Billing Address Addr2    ${addr2}
    END

    Input Billing Address Zip    ${zip}
    Input Billing Address Phone    ${phone}

    IF    "${fax}" != "${None}"
        Input Billing Address Fax    ${fax}
    END

# --------------------------------------------

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

Click Payment Information Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[payment_info][continue_button]

# --------------------------------------------

Click Confirm Order Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[confirm_order_button]

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
