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
Resource                                                                        ${EXECDIR}/Lib/Cart.robot

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

Shopping For Shoes And 4 Custom Tshirt Using Second Day Air Shipping And Cheque/Money Order Payment As A New User
    [Tags]    Workflow  Testcase4
    [Documentation]   Shopping for shoes and 4 Custom Tshirt using second day air shipping and Cheque/Money Order payment as a new user

    Open Webui    ${browser}    ${url}
    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]

    Do Registration
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[2]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False
    Proceed To Apparel Page
    Proceed To Shoes Page

    Add Shoes    Nike Floral Roshe Customized Running Shoes
    ...      size=11    print=Natural   list_color=White/Black
    Verify Successful Addition


    Go Back

    Add Shoes    adidas Consortium Campus 80s Running Shoes
    ...     size=11   square_color=blue   count=3
    Verify Successful Addition


    Go To    ${url}clothing
    Add Clothes    Custom T-Shirt   custom_text=My New Shirt    count=4
    Verify Successful Addition

    Proceed To Shopping Cart
    Check Item In Cart    Nike Floral Roshe Customized Running Shoes
    Check Item In Cart    adidas Consortium Campus 80s Running Shoes
    Check Item In Cart    Custom T-Shirt
    #need to be modified  to #Proceed To Checkout
    Select Term And Conditions
  #  Select Checkbox    //*[@id="termsofservice"]
    Click Button    //*[@id="checkout"]

    
    Fill Default Checkout Details    shipping_type=Second Day Air    payment_method=Check/Money Order
    ...    firstName=${test_data}[checkout][firstname]     lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]

    Proceed To Order Details Page
    Verify Order Details Are Visible
    Close All Browsers

Window Shopping For Clothes And Shoes As A Registered User
    [Documentation]   Window Shopping For Clothes And Shoes As A Registered User and not buying anything
    [Tags]    Workflow    TestCase5
    Open Webui    ${browser}    ${url}
    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]

    Do Registration
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[1]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False
    Logout
    Login    ${valid_emails}[1]   ${test_data}[register][valid_password]

    Search Store    shirt

    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=2X   count=2

    Search Store    shoes

    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=10     square_color=silver

    Proceed To Shopping Cart

    #modify count in shopping card
    Logout
    Close All Browsers

Shopping for Shoes and Shirt as a new registered user(Registering After Shopping)
    [Documentation]     Shopping for Shoes and Shirt as a new registered user(Registering After Shopping)
    [Tags]    Workflow    TestCase6
    Open Webui    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    View By List
    Add Shoes    Nike SB Zoom Stefan Janoski    count=2
    Verify Successful Addition
    Proceed To Apparel Page
    Proceed To Clothing Page
    View By List
    Add Clothes    Custom T-Shirt  count=3    custom_text=My shirt
    Verify Successful Addition
    Go Back
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt     size=Small
    Verify Successful Addition
    Proceed To Shopping Cart
    Check Item In Cart    Nike SB Zoom Stefan Janoski
    Check Item In Cart    Custom T-Shirt
    #Delete Nike Shirt
    Select Term And Conditions
    Click Button    //*[@id="checkout"]

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]

    Do Registration
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[4]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False

    Proceed To Shopping Cart
    Select Term And Conditions
    Click Button    //*[@id="checkout"]

    Fill Default Checkout Details    shipping_type=Ground    payment_method=Check/Money Order   same_shipping_addr=False
    ...    firstName=${test_data}[checkout][firstname]     lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    ...    firstName_ship=Tom     lastName_ship=Hanks
    ...    email_ship=tom123@gmail.com    country_ship=1
    ...    state_ship=53    city_ship=Nome
    ...    addr1_ship=hno 234    zip_ship=1234    phone_ship=98989898989

    Proceed To Order Details Page
    Verify Order Details Are Visible
    Close All Browsers

***Keywords***

Login
    [Documentation]   High level function to perform login operations
    [Arguments]     ${mail}     ${password}
    Proceed To Login Page
    Fill Login Form With RememberMe       ${mail}     ${password}
    Click Login Button
    Verify Login Success

Do Registration
    [Documentation]   High level function to perform registration operations
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${password}
    ...            ${day}=0    ${month}=0    ${year}=0
    ...            ${gender}=None    ${company}=None
    ...            ${want_newsletter}=False

    Proceed To Register Page
    Fill Registration Form
    ...            ${firstName}    ${lastName}    ${email}    ${password}
    ...            ${day}    ${month}    ${year}
    ...            ${gender}    ${company}
    ...            ${want_newsletter}
    Click Register Button
    Verify Successful Registration

Fill Default Shipping Method Form
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

    [Arguments]     ${payment_method}
    Verify Payment Method Form Is Visible

    IF  "${payment_method}" == "Check/Money Order"
        Choose Payment Method As Check Or Money Order
    ELSE IF  "${payment_method}" == "Credit Card"
        Choose Payment Method As Credit Card
    END

    Click Payment Method Continue Button

Fill Default Payment Details

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
    [Documentation]     Higher level function to perform all checkout operations
    [Arguments]    ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}    ${state}
    ...            ${shipping_type}    ${payment_method}
    ...            ${firstName_ship}=None    ${lastName_ship}=None     ${email_ship}=None
    ...            ${country_ship}=None     ${city_ship}=None     ${addr1_ship}=None    ${zip_ship}=None    ${phone_ship}=None
    ...            ${state_ship}=None
    ...            ${company}=None    ${addr2}=None    ${fax}=None
    ...            ${company_ship}=None    ${addr2_ship}=None    ${fax_ship}=None
    ...            ${same_shipping_addr}=True

    IF  "${same_shipping_addr}"=="True"
        Select Same Shipping Address Checkbox
    ELSE
        Unselect Same Shipping Address Checkbox
    END

    Fill Billing Address Form
        ...    firstName=${firstName}    lastName=${lastName}
        ...    email=${email}    country=${country}
        ...    state=${state}    city=${city}
        ...    addr1=${addr1}    zip=${zip}    phone=${phone}
    Click Billing Address Continue Button

    IF  "${same_shipping_addr}"!="True"
        Verify Shipping Address Form Is Visible
        Select Shipping Address As New Address

        Fill Shipping Address Form
        ...    firstName=${firstName_ship}    lastName=${lastName_ship}
        ...    email=${email_ship}    country=${country_ship}
        ...    state=${state_ship}   city=${city_ship}
        ...    addr1=${addr1_ship}    addr2=${addr2_ship}
        ...    zip=${zip_ship}    phone=${phone_ship}
        ...    company=${company_ship}    fax=${fax_ship}

        Click Shipping Address Continue Button
    END
    Fill Default Shipping Method Form     ${shipping_type}
    Fill Default Payment Method Form    ${payment_method}

    Fill Default Payment Details    ${payment_method}

    Verify Confirm Order Form Is Visible
    Click Confirm Order Button

    Verify Successful Checkout
