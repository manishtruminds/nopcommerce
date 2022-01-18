# Test Suite for Register page
*** Settings ***
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
    [Documentation]    Test required fields

    Open Webui    ${browser}    ${url}register
    Page Should Contain    Register

    # don't fill anything, simply click on Register

    Click Register Button

    Verify Unsuccessful Registration

    Close All Browsers

Optional Registration Fields
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test optional fields

    Open Webui    ${browser}    ${url}register
    Page Should Contain    Register

    Fill Registration Form    ${EMPTY}    david    knuth    ${EMPTY}    ${EMPTY}    ${EMPTY}    davidknuth11@mail.com    ${EMPTY}    yesyes    ${True}
    Click Register Button

    Sleep    5

    Verify Successful Registration

    Close All Browsers


Valid Registration
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test a Valid Registration

    Open Webui    ${browser}    ${url}register

    Page Should Contain    Register

    Fill Registration Form    M    david    knuth    10    1    1938    davidknuth12@mail.com    acme    yesyes    ${True}
    Click Register Button

    Sleep    5

    Verify Successful Registration
    
    Close All Browsers

Invalid Registration
    [Tags]    WebUI    WebUI_Register
    [Documentation]    Test an invalid Registration

    Open Webui    ${browser}    ${url}register

    Page Should Contain    Register

    Fill Registration Form    M    david    knuth    10    1    1938    davidknuth    acme    yesyes    ${True}
    Click Register Button

    Verify Unsuccessful Registration
    
    Close All Browsers
    