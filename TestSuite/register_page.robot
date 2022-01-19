# Test Suite for Register page
*** Settings ***
Library    String

Resource    ${EXECDIR}/Lib/Common_Utils.robot
Resource    ${EXECDIR}/Lib/Register.robot 
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Register.robot

Variables    ${EXECDIR}/Variables/env.yaml
Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml

*** Variables ***
# Device test variables
${browser}    ${env_variables}[${ENV_TYPE}][browser]
${url}        ${env_variables}[${ENV_TYPE}][url]

*** Test Cases ***

Required Registration Fields
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test that registration requires required fields to be filled

    Open Webui    ${browser}    ${url}register
    Page Should Contain    Register

    # don't fill anything, simply click on Register

    Click Register Button

    Verify Unsuccessful Registration

    [Teardown]    Close All Browsers

Optional Registration Fields
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test that registration doesn't require optional fields to be filled

    Open Webui    ${browser}    ${url}register
    Page Should Contain    Register

    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${test_data}[register][valid_email1]    password=${test_data}[register][valid_password]
    #...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False

    Click Register Button

    Sleep    5

    Verify Successful Registration

    [Teardown]    Close All Browsers


Valid Registration
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test a Valid Registration with all data filled

    Open Webui    ${browser}    ${url}register

    Page Should Contain    Register

    Fill Registration Form
    ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
    ...    email=${test_data}[register][valid_email2]    password=${test_data}[register][valid_password]
    ...    day=10    month=1    year=1997    gender=M    company=acme    want_newsletter=False
    
    Click Register Button

    Sleep    5

    Verify Successful Registration
    
    [Teardown]    Close All Browsers

Invalid Registration Email
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test an invalid registration with invalid emails

    Open Webui    ${browser}    ${url}register

    Page Should Contain    Register

    ${invalid_emails}=       Split String    ${test_data}[register][invalid_emails]    |
    #${invalid_passwords}=    Split String    ${test_data}[register][invalid_passwords]    |

    FOR    ${invalid_email}    IN    @{invalid_emails}
        Log    ${invalid_email}
        
        Fill Registration Form
        ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
        ...    email=${invalid_email}    password=${test_data}[register][valid_password]
        
        Click Register Button

        
        Verify Unsuccessful Registration
        Verify Invalid Email Message

    END
    
    [Teardown]    Close All Browsers

Invalid Registration Password
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test an invalid registration with invalid passwords

    Open Webui    ${browser}    ${url}register

    Page Should Contain    Register

    ${invalid_passwords}=    Split String    ${test_data}[register][invalid_passwords]    |

    FOR    ${invalid_password}    IN    @{invalid_passwords}
        Log    ${invalid_password}
        
        Fill Registration Form
        ...    firstName=${test_data}[register][firstname]    lastName=${test_data}[register][lastname]
        ...    email=${test_data}[register][valid_email3]    password=${invalid_password}
        
        Click Register Button

        
        Verify Unsuccessful Registration
        Verify Invalid Password Message

    END
    
    [Teardown]    Close All Browsers
