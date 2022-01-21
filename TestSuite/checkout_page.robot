# Test Suite for Register page
*** Settings ***
Library    String
Library    Collections

Resource    ../Lib/Checkout.robot 
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Home.robot

Variables    ${EXECDIR}/Variables/env.yaml
Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml

*** Variables ***
# Device test variables
${browser}    ${env_variables}[${ENV_TYPE}][browser]
${url}        ${env_variables}[${ENV_TYPE}][url]

*** Test Cases ***
Keyword Tests
    Add Desktop And Proceed To Checkout As Guest
    Page Should Contain    Checkout

    Unselect Same Shipping Address Checkbox
    Sleep    1
    #Select Same Shipping Address Checkbox

    Fill Billing Address Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=dk@mail.com    country=1    state=52    city=Anchorage
    ...    addr1=house no. 123    addr2=abc street    zip=99501    phone=98989282
    ...    company=acme    fax=123456

    #Verify Invalid Email Message


    Click Billing Address Continue Button

    Select Shipping Address As New Address
    
    Fill Shipping Address Form
    ...    firstName=donald    lastName=davis
    ...    email=dd@mail.com    country=1    state=52    city=Anchorage
    ...    addr1=house no. 456    addr2=xyz street    zip=99502    phone=98989282768
    ...    company=acme    fax=123456

    Click Shipping Address Continue Button

    #Verify Invalid Email Message


    Choose Shipping Method As Ground
    Sleep    1
    Choose Shipping Method As Next Day Air
    Sleep    1
    Choose Shipping Method As Second Day Air
    Sleep    2
    Click Shipping Method Continue Button


    Choose Payment Method As Check Or Money Order
    Sleep    1
    Click Payment Method Continue Button
    Verify Check Or Money Order Payment Information Message
    Click Payment Information Continue Button

    
    # # Choose Payment Method As Credit Card
    # # Sleep    1
    # # Click Payment Method Continue Button
    # # Verify Credit Card Payment Information Message
    
    # # Fill Payment Information Credit Card Form
    # # ...    card_type=Amex    cardholder_name=david knuth    card_number=123456789101112131415
    # # ...    expiration_month=5    expiration_year=2024    card_code=6
    # # Sleep    2
    
    # # Click Payment Information Continue Button
    # # Verify Invalid Card Number Message
    # # Verify Invalid Card Code Message



    Sleep    2
    Click Confirm Order Button

    Verify Successful Checkout
