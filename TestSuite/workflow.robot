*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Home.robot
Resource    ../Lib/Apparel.robot
Resource    ../Lib/Clothing.robot
Resource    ../Lib/Shoes.robot
Resource    ../Lib/Checkout.robot
Resource    ../Lib/Register.robot
Resource    ../Lib/Login.robot
Resource    ../Lib/Cart.robot

Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml

Variables    ${EXECDIR}/Variables/env.yaml
Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml

Documentation    This resource file contains keywords for dealing with workflows

*** Variables ***
# Device test variables
${browser}                                  ${env_variables}[${ENV_TYPE}][browser]
${url}                                      ${env_variables}[${ENV_TYPE}][url]

*** Test Cases ***
Shopping for Nike Shoes As Guest Using Ground Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Workflow    WTC1
    [Documentation]    Test the workflow of adding Nike shoes to cart, checking out as guest, using ground shipping and check or money order payment

    Open WebUI    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page

    Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=White/Blue     size=9   print=Fresh
    Verify Successful Addition

    Proceed To Shopping Cart
    Check Item In Cart    Nike Floral Roshe Customized Running Shoes    size=9    color=White/Blue    print=Fresh
    Proceed To Checkout As Guest

    Fill Default Checkout Details And Confirm Order    shipping_type=Ground    payment_method=Check/Money Order
    Verify Successful Checkout

    Proceed To Order Details Page
    Verify Order Details Are Visible

    Close All Browsers


Shopping for Custom T-shirt As Registered User Using Next Day Air Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Workflow    WTC2
    [Documentation]    Test the workflow of adding custom T-shirt to cart, checking out as a registered user, using next day air shipping and check or money order payment

    Open Webui    ${browser}    ${url}

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][valid_emails]
    Perform Default Registration And Continue    email=${valid_emails}[0]

    Verify Login Success

    Proceed To Apparel Page
    Proceed To Clothing Page

    Add Clothes    Custom T-Shirt   custom_text=My New Shirt
    Verify Successful Addition

    Proceed To Shopping Cart
    Check Item In Cart    Custom T-Shirt    custom_text=My New Shirt
    Proceed To Checkout As Signed In User

    Fill Default Checkout Details And Confirm Order    shipping_type=Next Day Air    payment_method=Check/Money Order
    Verify Successful Checkout

    Proceed To Order Details Page
    Verify Order Details Are Visible

    Close All Browsers

Shopping for Nike T-shirt And Adidas Shoes As Registered User Using Next Day Air Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Workflow    WTC3
    [Documentation]    Test the workflow of adding Nike T-shirt And Adidas Shoes to cart, checking out as a registered user, using second day air shipping and check or money order payment

    Open Webui    ${browser}    ${url}
    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][valid_emails]
    Perform Default Registration And Continue    email=${valid_emails}[1]

    Verify Login Success

    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=1X
    Verify Successful Addition

    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=9
    Verify Successful Addition

    Proceed To Shopping Cart
    Check Item In Cart    Nike Tailwind Loose Short-Sleeve Running Shirt   size=1X
    Check Item In Cart    adidas Consortium Campus 80s Running Shoes     size=9
    Proceed To Checkout As Signed In User

    Fill Default Checkout Details And Confirm Order    shipping_type=Next Day Air    payment_method=Check/Money Order

    Verify Successful Checkout

    Proceed To Order Details Page
    Verify Order Details Are Visible

    Close All Browsers


Shopping For Shoes And 4 Custom Tshirt Using Second Day Air Shipping And Cheque/Money Order Payment As A New User
    [Tags]    WebUI    WebUI_Workflow  WTC4
    [Documentation]   Shopping for shoes and 4 Custom Tshirt using second day air shipping and Cheque/Money Order payment as a new user

    Open Webui    ${browser}    ${url}
    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][valid_emails]
    Perform Default Registration And Continue    email=${valid_emails}[2]

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

    Proceed To Checkout As Signed In User
    Fill Default Checkout Details And Confirm Order    shipping_type=Ground    payment_method=Check/Money Order
    Verify Successful Checkout


    Proceed To Order Details Page
    Verify Order Details Are Visible
    Close All Browsers

Window Shopping For Clothes And Shoes As A Registered User
    [Tags]    WebUI    WebUI_Workflow    WTC5
    [Documentation]   Window Shopping For Clothes And Shoes As A Registered User and not buying anything

    Open Webui    ${browser}    ${url}
    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][valid_emails]
    Perform Default Registration And Continue    email=${valid_emails}[3]

    Logout
    Login    ${valid_emails}[3]   ${test_data}[register][valid_password]

    Search Store    shirt

    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=2X   count=2

    Search Store    shoes

    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=10     square_color=silver

    Proceed To Shopping Cart

    #modify count in shopping card
    Logout
    Close All Browsers

Shopping for Shoes and Shirt as a new registered user(Registering After Shopping)
    [Tags]    WebUI    WebUI_Workflow    WTC6
    [Documentation]     Shopping for Shoes and Shirt as a new registered user(Registering After Shopping)

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
    Proceed To Checkout As Guest

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][valid_emails]
    Perform Default Registration And Continue    email=${valid_emails}[4]

    Proceed To Shopping Cart
    Proceed To Checkout As Signed In User

    Fill Default Checkout Details And Confirm Order    shipping_type=Ground    payment_method=Check/Money Order
    Verify Successful Checkout

    Proceed To Order Details Page
    Verify Order Details Are Visible
    ${order_num}=     Get Text    //div[@class='order-number']//strong
    Log To Console    ${order_num}
    Click Element    //a[contains(text(),'PDF Invoice')]
    #OperatingSystem.File Should Exist    C:\\Users\\user\\Downloads\\order1.pdf

    Close All Browsers


*** Keywords ***
Proceed To Checkout As Guest
    Select Term And Conditions
    Click Checkout Button    signed_in=No
    Click Checkout As Guest Button

Proceed To Checkout As Signed In User
    Select Term And Conditions
    Click Checkout Button    signed_in=Yes

Login
    [Documentation]   High level function to perform login operations
    [Arguments]     ${mail}     ${password}
    Proceed To Login Page
    Fill Login Form With RememberMe       ${mail}     ${password}
    Click Login Button
    Verify Login Success

Perform Default Registration And Continue
    [Arguments]    ${email}
    [Documentation]   High level function to perform registration operations

    Proceed To Register Page
    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${email}    password=${test_data}[register][valid_password]

    Click Register Button
    Verify Successful Registration

Fill Default Billing Address Form And Continue
    Fill Billing Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    addr2=${test_data}[checkout][addr2]
    ...    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    ...    company=${test_data}[checkout][company]    fax=${test_data}[checkout][fax]

    Click Billing Address Continue Button

Fill Default Shipping Address Form And Continue
    Verify Shipping Address Form Is Visible

    Fill Shipping Address Form
    ...    firstName=${test_data}[checkout][firstname]    lastName=${test_data}[checkout][lastname]
    ...    email=${test_data}[checkout][valid_email]    country=${test_data}[checkout][country]
    ...    state=${test_data}[checkout][state]    city=${test_data}[checkout][city]
    ...    addr1=${test_data}[checkout][addr1]    addr2=${test_data}[checkout][addr2]
    ...    zip=${test_data}[checkout][zip]    phone=${test_data}[checkout][phone]
    ...    company=${test_data}[checkout][company]    fax=${test_data}[checkout][fax]

    Click Shipping Address Continue Button

Fill Shipping Method Form And Continue
    [Arguments]     ${shipping_method}

    Verify Shipping Method Form Is Visible

    IF  "${shipping_method}" == "Ground"
        Choose Shipping Method As Ground
    ELSE IF  "${shipping_method}" == "Next Day Air"
        Choose Shipping Method As Next Day Air
    ELSE IF  "${shipping_method}" == "Second Day Air"
        Choose Shipping Method As Second Day Air
    END

    Click Shipping Method Continue Button

Fill Payment Method Form And Continue
    [Arguments]     ${payment_method}

    Verify Payment Method Form Is Visible

    IF  "${payment_method}" == "Check/Money Order"
        Choose Payment Method As Check Or Money Order
    ELSE IF  "${payment_method}" == "Credit Card"
        Choose Payment Method As Credit Card
    END

    Click Payment Method Continue Button

Fill Payment Details Form And Continue
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

Fill Default Checkout Details And Confirm Order
    [Arguments]    ${shipping_type}    ${payment_method}    ${same_shipping_addr}=True
    [Documentation]     Higher level function to perform all checkout operations

    IF  "${same_shipping_addr}"=="True"
        Select Same Shipping Address Checkbox
    ELSE
        Unselect Same Shipping Address Checkbox
    END

    Fill Default Billing Address Form And Continue

    IF  "${same_shipping_addr}"!="True"
        Verify Shipping Address Form Is Visible
        Select Shipping Address As New Address
        Fill Default Shipping Address Form And Continue
    END

    Fill Shipping Method Form And Continue    ${shipping_type}
    Fill Payment Method Form And Continue    ${payment_method}
    Fill Payment Details Form And Continue    ${payment_method}

    Verify Confirm Order Form Is Visible
    Click Confirm Order Button
