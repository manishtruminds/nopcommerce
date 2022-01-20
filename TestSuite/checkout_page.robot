# Test Suite for Register page
*** Settings ***
Library    String
Library    Collections

Resource    ${EXECDIR}/Lib/Common_Utils.robot
Resource    ${EXECDIR}/Lib/Checkout.robot 
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
    Select Same Shipping Address Checkbox


    Fill Billing Address Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=dk@mail.com    country=1    state=52    city=Anchorage
    ...    addr1=house no. 123    addr2=abc street    zip=99501    phone=98989282
    ...    company=acme    fax=123456

    Click Billing Address Continue Button
