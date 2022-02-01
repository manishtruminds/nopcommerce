*** Settings ***
Library     SeleniumLibrary
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Home.robot
Resource    ../Lib/Apparel.robot
Resource    ../Lib/Clothing.robot
Resource    ../Lib/Shoes.robot
Resource    ../Lib/Cart.robot

Variables    ${EXECDIR}/Variables/webelement.yaml

Documentation    This resource file contains keywords for dealing with the checkout page

*** Keywords ***
Click Checkout As Guest Button
    [Documentation]    Click the Checkout as guest button during the checkout process
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[checkout_as_guest_button]

Add Nike Floral Shoes To Cart And Checkout As Guest
    [Arguments]    ${list_color}=White/Blue     ${size}=9   ${print}=Fresh
    [Documentation]    Adds Nike Floral Shoes into the cart and clicks on checkout as guest button.
    ...                This keyword is meant to be used only in the checkout test cases to add an
    ...                initial item in the cart for checking out.
    Open Webui  ${browser}  ${url}

    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=${list_color}     size=${size}   print=${print}
    Verify Successful Addition

    Proceed To Shopping Cart

    Select Term And Conditions
    Click Checkout Button    signed_in=No

    Click Checkout As Guest Button

    Page Should Contain    Checkout

# --------------------------------------------
Select Same Shipping Address Checkbox
    [Documentation]    Selects the same shipping address checkbox during the checkout process
    Wait Until Element Is Visible    ${checkout}[billing_addr][ship_to_same_addr]    10s

    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]
    IF    ${is_checked} == ${False}
        Select Checkbox    ${checkout}[billing_addr][ship_to_same_addr]
    END
    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]

Unselect Same Shipping Address Checkbox
    [Documentation]    Unselects the same shipping address checkbox during the checkout process
    Wait Until Element Is Visible    ${checkout}[billing_addr][ship_to_same_addr]    10s

    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]
    IF    ${is_checked} == ${True}
        Unselect Checkbox    ${checkout}[billing_addr][ship_to_same_addr]
    END

    Checkbox Should Not Be Selected   ${checkout}[billing_addr][ship_to_same_addr]

Input Address Form FirstName
    [Arguments]   ${addr_type}    ${firstName}
    [Documentation]    A generic keyword to fill firstname field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[${addr_type}][firstname]  ${firstName}

Input Address Form LastName
    [Arguments]   ${addr_type}    ${lastName}
    [Documentation]    A generic keyword to fill lastname field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[${addr_type}][lastname]  ${lastName}

Input Address Form Email
    [Arguments]    ${addr_type}    ${email}
    [Documentation]    A generic keyword to fill email field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[${addr_type}][email]  ${email}

Input Address Form Company
    [Arguments]    ${addr_type}    ${company}
    [Documentation]    A generic keyword to fill company field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][company]  ${company}

Select Address Form Country
    [Arguments]    ${addr_type}    ${country}
    [Documentation]    A generic keyword to select country in the billing/shipping addr form.
    
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[${addr_type}][country]    ${country}

Select Address Form State
    [Arguments]    ${addr_type}    ${state}
    [Documentation]    A generic keyword to select state in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[${addr_type}][state]    ${state}

Input Address Form City
    [Arguments]    ${addr_type}    ${city}
    [Documentation]    A generic keyword to fill city field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][city]  ${city}

Input Address Form Addr1
    [Arguments]    ${addr_type}    ${addr1}
    [Documentation]    A generic keyword to fill address 1 field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][addr1]  ${addr1}

Input Address Form Addr2
    [Arguments]    ${addr_type}    ${addr2}
    [Documentation]    A generic keyword to fill address 2 field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][addr2]  ${addr2}

Input Address Form Zip
    [Arguments]    ${addr_type}    ${zip}
    [Documentation]    A generic keyword to fill zip field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][zip]  ${zip}

Input Address Form Phone
    [Arguments]    ${addr_type}    ${phone}
    [Documentation]    A generic keyword to fill phone field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][phone]  ${phone}

Input Address Form Fax
    [Arguments]    ${addr_type}    ${fax}
    [Documentation]    A generic keyword to fill fax field in the billing/shipping addr form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[${addr_type}][fax]  ${fax}

Fill Address Form
    [Arguments]    ${addr_type}
    ...            ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}
    ...            ${state}    ${company}=None    ${addr2}=None    ${fax}=None
    [Documentation]    A high level wrapper keyword to fill the billing/shipping addr form.


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
    [Documentation]    A high level wrapper keyword that fills the billing address form.


    Fill Address Form    addr_type=billing_addr
    ...            firstName=${firstName}    lastName=${lastName}    email=${email}
    ...            country=${country}    city=${city}    addr1=${addr1}    zip=${zip}    phone=${phone}
    ...            state=${state}    company=${company}    addr2=${addr2}    fax=${fax}

Click Billing Address Continue Button
    [Documentation]    Click the continue button on the billing address form page.
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
    [Documentation]    Select "New Address" option from the shipping address drop down
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Label    ${checkout}[shipping_addr][select_shipping_addr]    New Address

Fill Shipping Address Form
    [Arguments]    ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}
    ...            ${state}    ${company}=None    ${addr2}=None    ${fax}=None
    [Documentation]    A high level wrapper keyword that fills the shipping address form.


    Fill Address Form    addr_type=shipping_addr
    ...            firstName=${firstName}    lastName=${lastName}    email=${email}
    ...            country=${country}    city=${city}    addr1=${addr1}    zip=${zip}    phone=${phone}
    ...            state=${state}    company=${company}    addr2=${addr2}    fax=${fax}

Click Shipping Address Continue Button
    [Documentation]    Click the continue button on the shipping address form page.

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
    [Documentation]    Select the Ground shipping method radio button.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[shipping_method][radio_shipping_method]    Ground___Shipping.FixedByWeightByTotal
    Radio Button Should Be Set To    ${checkout}[shipping_method][radio_shipping_method]    Ground___Shipping.FixedByWeightByTotal

Choose Shipping Method As Next Day Air
    [Documentation]    Select the Next Day Air shipping method radio button.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[shipping_method][radio_shipping_method]    Next Day Air___Shipping.FixedByWeightByTotal
    Radio Button Should Be Set To    ${checkout}[shipping_method][radio_shipping_method]    Next Day Air___Shipping.FixedByWeightByTotal

Choose Shipping Method As Second Day Air
    [Documentation]    Select the Second Day Air shipping method radio button.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[shipping_method][radio_shipping_method]    2nd Day Air___Shipping.FixedByWeightByTotal
    Radio Button Should Be Set To    ${checkout}[shipping_method][radio_shipping_method]    2nd Day Air___Shipping.FixedByWeightByTotal

Click Shipping Method Continue Button
    [Documentation]    Click the continue button on the shipping method form page.

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
    [Documentation]    Select the Check Or Money Order payment method radio button.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[payment_method][radio_payment_method]    Payments.CheckMoneyOrder
    Radio Button Should Be Set To    ${checkout}[payment_method][radio_payment_method]    Payments.CheckMoneyOrder

Choose Payment Method As Credit Card
    [Documentation]    Select the Credit Card payment method radio button.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${checkout}[payment_method][radio_payment_method]    Payments.Manual
    Radio Button Should Be Set To    ${checkout}[payment_method][radio_payment_method]    Payments.Manual

Click Payment Method Continue Button
    [Documentation]    Click the continue button on the payment method form page.

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
    [Documentation]    Select the type of credit card from the dropdown on the payment information form page.
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[payment_info][credit_card]    ${card}

Input Payment Information Cardholder Name
    [Arguments]   ${name}
    [Documentation]    Fill cardholder name field in the payment information credit card form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[payment_info][cardholder_name]    ${name}

Input Payment Information Card Number
    [Arguments]   ${cnum}
    [Documentation]    Fill card number field in the payment information credit card form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[payment_info][card_number]    ${cnum}

Input Payment Information Card Expiration Date
    [Arguments]    ${month}    ${year}
    [Documentation]    Fill card expiration date fields in the payment information credit card form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[payment_info][expire_month]    ${month}

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[payment_info][expire_year]    ${year}

Input Payment Information Card Code
    [Arguments]   ${code}
    [Documentation]    Fill card code field in the payment information credit card form.

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[payment_info][card_code]    ${code}

Fill Payment Information Credit Card Form
    [Arguments]    ${card_type}    ${cardholder_name}    ${card_number}
    ...            ${expiration_month}    ${expiration_year}    ${card_code}
    [Documentation]    A high level wrapper to fill the payment information credit card form.


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
    [Documentation]    Click the continue button on the payment information form page.

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

Proceed To Order Details Page
    [Documentation]    Click on the order details links after successful checkout.
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Link    ${checkout}[order_details_link]

Verify Order Details Are Visible
    Element Should Be Visible    ${checkout}[order_details_info]
    Page Should Contain    Order information
