*** Settings ***
Library     SeleniumLibrary
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

Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml

Documentation    This resource file contains keywords for dealing with workflows

*** Keywords ***
Proceed To Checkout
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Checkbox    //*[@id="termsofservice"]
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    //*[@id="checkout"]

*** Test Cases ***
Shopping for Nike Shoes As Guest Using Ground Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Workflow
    [Documentation]    Test the workflow of adding Nike shoes to cart, checking out as guest, using ground shipping and check or money order payment

    Open WebUI    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    
    Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=White/Blue     size=9   print=Fresh
    Verify Successful Addition

    Proceed To Shopping Cart
    Proceed To Checkout
    Click Checkout As Guest Button

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

    Proceed To Order Details Page
    Verify Order Details Are Visible

    Close All Browsers


Shopping for Custom T-shirt As Registered User Using Next Day Air Shipping And Check Or Money Order Payment 
    [Tags]    WebUI    WebUI_Workflow
    [Documentation]    Test the workflow of adding custom T-shirt to cart, checking out as a registered user, using next day air shipping and check or money order payment

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][valid_emails]
    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[0]    password=${test_data}[register][valid_password]
    Click Register Button
    Verify Successful Registration
    Verify Login Success
    
    Proceed To Apparel Page
    Proceed To Clothing Page
    
    Add Clothes    Custom T-Shirt   custom_text=My New Shirt
    Verify Successful Addition
    
    Proceed To Shopping Cart
    Proceed To Checkout
    # Click Checkout As Guest Button

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

    Proceed To Order Details Page
    Verify Order Details Are Visible

    Close All Browsers

Shopping for Nike T-shirt And Adidas Shoes As Registered User Using Next Day Air Shipping And Check Or Money Order Payment
    [Tags]    WebUI    WebUI_Workflow
    [Documentation]    Test the workflow of adding Nike T-shirt And Adidas Shoes to cart, checking out as a registered user, using second day air shipping and check or money order payment
    
    Open Webui    ${browser}    ${url}
    Proceed To Register Page
    
    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[checkout][valid_emails]
    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[1]    password=${test_data}[register][valid_password]
    Click Register Button
    Verify Successful Registration
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
    Proceed To Checkout

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

    Proceed To Order Details Page
    Verify Order Details Are Visible

    Close All Browsers
