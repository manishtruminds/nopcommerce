#First commit for workflow2 branch

*** Settings ***
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
Resource                                                                        ${EXECDIR}/Lib/Login.robot
Resource                                                                        ${EXECDIR}/Lib/Register.robot
Resource                                                                        ${EXECDIR}/Lib/Home.robot
Resource                                                                        ${EXECDIR}/Lib/Apparel.robot
Resource                                                                        ${EXECDIR}/Lib/Clothing.robot
Resource                                                                        ${EXECDIR}/Lib/Shoes.robot

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
