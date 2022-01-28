# Test Suite for Register page
*** Settings ***
Library    String
Library    Collections

Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Register.robot
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Register.robot
Resource    ../Lib/Home.robot

Variables    ${EXECDIR}/Variables/env.yaml
Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml

*** Variables ***
# Device test variables
${browser}    ${env_variables}[${ENV_TYPE}][browser]
${url}        ${env_variables}[${ENV_TYPE}][url]

*** Test Cases ***

Required Registration Fields
    [Tags]    WebUI    WebUI_Register   test
    [Documentation]    Test that registration requires required fields to be filled

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    # don't fill anything, simply click on Register

    Click Register Button

    Verify Unsuccessful Registration
    Sleep    5
    Close All Browsers

Optional Registration Fields
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test that registration doesn't require optional fields to be filled

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]

    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[0]    password=${test_data}[register][valid_password]
    #...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False

    Click Register Button

    Verify Successful Registration

    Close All Browsers


Valid Registration
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test a Valid Registration with all data filled

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]

    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[1]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False

    Click Register Button

    Verify Successful Registration

    Close All Browsers

Invalid Registration Email
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test an invalid registration with invalid emails

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    @{invalid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][invalid_emails]

    FOR    ${invalid_email}    IN    @{invalid_emails}
        Log    ${invalid_email}

        Fill Registration Form
        ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
        ...    email=${invalid_email}    password=${test_data}[register][valid_password]

        Click Register Button


        Verify Unsuccessful Registration
        Verify Invalid Email Message

    END

    Close All Browsers

Invalid Registration Password
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test an invalid registration with invalid passwords

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]
    @{invalid_passwords}=    Get Test Data From Pipe Separated String    ${test_data}[register][invalid_passwords]

    FOR    ${invalid_password}    IN    @{invalid_passwords}
        Log    ${invalid_password}

        Fill Registration Form
        ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
        ...    email=${valid_emails}[2]    password=${invalid_password}

        Click Register Button


        Verify Unsuccessful Registration
        Verify Invalid Password Message

    END

    Close All Browsers

Duplicate Registration
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Ensure that duplicate registrations is not possible

    @{valid_emails}=    Get Test Data From Pipe Separated String    ${test_data}[register][valid_emails]

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[3]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False

    Click Register Button

    Verify Successful Registration

    Close All Browsers

    # Retry the same registration, this time, it should be unsuccessful

    Open Webui    ${browser}    ${url}
    Proceed To Register Page

    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${valid_emails}[3]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False

    Click Register Button

    Verify Unsuccessful Registration
    Verify Email Already Exists Message

    Close All Browsers
