#First commit for workflow2 branch

*** Settings ***
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
Resource                                                                        ${EXECDIR}/Lib/Login.robot
Resource                                                                        ${EXECDIR}/Lib/Register.robot
Resource                                                                        ${EXECDIR}/Lib/Home.robot
Resource                                                                        ${EXECDIR}/Lib/Apparel.robot
Resource                                                                        ${EXECDIR}/Lib/Clothing.robot
Resource                                                                        ${EXECDIR}/Lib/Shoes.robot
Resource                                                                        ${EXECDIR}/Lib/Checkout.robot

Library                                                                         SeleniumLibrary
Library                                                                         DependencyLibrary
Library                                                                         OperatingSystem
Library                                                                         DateTime
Library                                                                         String
Library                                                                         Collections
Library                                                                         SSHLibrary


Variables                                                                       ${EXECDIR}/Variables/env.yaml
Variables                                                                       ${EXECDIR}/Variables/webelement.yaml
Variables                                                                       ${EXECDIR}/Variables/testdata.yaml

*** Variables ***
# Device test variables
${browser}                                  ${env_variables}[${ENV_TYPE}][browser]
${url}                                      ${env_variables}[${ENV_TYPE}][url]
${username}                                 ${env_variables}[${ENV_TYPE}][username]
${password}                                 ${env_variables}[${ENV_TYPE}][password]


*** Test Cases ***

Shopping for shoes and 4 Custom Tshirt using second day air shipping and Cheque/Money Order payment as a new user
    [Tags]    Workflow  Testcase4
    [Documentation]   Shopping for shoes and 4 Custom Tshirt using second day air shipping and Cheque/Money Order payment as a new user

    Open Webui    ${browser}    ${url}
    Proceed To Register Page
    # can make keyword for this
    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]
    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[1]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False
    Click Register Button
    Verify Successful Registration

    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    Nike Floral Roshe Customized Running Shoes
    ...      size=11    print=Natural   list_color=White/Black
    Verify Successful Addition
    Go Back
    Add Shoes    adidas Consortium Campus 80s Running Shoes
    ...     size=11   square_color=blue   count=4
    Verify Successful Addition
    Go To    ${url}clothing
    Add Clothes    Custom T-Shirt   custom_text=My New Shirt    count=4
    Verify Successful Addition
    Proceed To Shopping Cart
    #need to be modified  to #Proceed To Checkout

    Select Checkbox    //*[@id="termsofservice"]
    Click Button    //*[@id="checkout"]
    # add attributes
    Fill Default Checkout Details    Second Day Air     Check/Money Order

    Close All Browsers

***Keywords***
Fill Default Billing Form
    [Documentation]
    Fill Billing Address Form
        ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
        ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
        ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
        ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    Click Billing Address Continue Button

Fill Default Shipping Form
    [Documentation]
    Verify Shipping Address Form Is Visible
    Select Shipping Address As New Address

    Fill Shipping Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    addr2=${test_data}[checkout][addr2]
    ...    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    ...    company=${test_data}[checkout][company]    fax=${test_data}[checkout][fax]

    Click Shipping Address Continue Button

Fill Default Shipping Method Form
    [Documentation]
    [Arguments]     ${shipping_type}
    Verify Shipping Method Form Is Visible
    IF  "${shipping_type}" == "Ground"
        Choose Shipping Method As Ground
    ELSE IF  "${shipping_type}" == "Next Day Air"
        Choose Shipping Method As Next Day Air
    ELSE IF  "${shipping_type}" == "Second Day Air"
        Choose Shipping Method As Second Day Air
    END
    Click Shipping Method Continue Button

Fill Default Payment Method Form
    [Documentation]
    [Arguments]     ${payment_method}
    Verify Payment Method Form Is Visible

    IF  "${payment_method}" == "Check/Money Order"
        Choose Payment Method As Check Or Money Order
    ELSE IF  "${payment_method}" == "Credit Card"
        Choose Payment Method As Credit Card
    END

    Click Payment Method Continue Button

Fill Default Payment Details
    [Documentation]
    [Arguments]     ${payment_method}

    Verify Payment Information Form Is Visible

    IF  "${payment_method}" == "Check/Money Order"
        Verify Check Or Money Order Payment Information Message
    ELSE IF  "${payment_method}" == "Credit Card"
        Verify Credit Card Payment Information Message
        Fill Payment Information Credit Card Form
        ...    card_type=${test_data}[checkout][card_type]    cardholder_name=${test_data}[checkout][cardholder_name]
        ...    card_number=${test_data}[checkout][card_number]    expiration_month=${test_data}[checkout][expiration_month]
        ...    expiration_year=${test_data}[checkout][expiration_year]    card_code=${test_data}[checkout][card_code]
    END

    Click Payment Information Continue Button

Fill Default Checkout Details
    [Arguments]     ${shipping_type}    ${payment_method}   ${same_shipping_addr}=True
    IF  "${same_shipping_addr}"=="True"
        Select Same Shipping Address Checkbox
    ELSE
        Unselect Same Shipping Address Checkbox
    END
    Fill Default Billing Form
    IF  "${same_shipping_addr}"!="True"
        Fill Default Shipping Form
    END
    Fill Default Shipping Method Form     ${shipping_type}
    Fill Default Payment Method Form    ${payment_method}

    Fill Default Payment Details    ${payment_method}

    Verify Confirm Order Form Is Visible
    Click Confirm Order Button

    Verify Successful Checkout
