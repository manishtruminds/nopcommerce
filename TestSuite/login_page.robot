# First commit for Login page
# changes
*** Settings ***
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
Resource                                                                        ${EXECDIR}/Lib/Login.robot
Resource                                                                        ${EXECDIR}/Lib/Register.robot
Resource                                                                        ${EXECDIR}/Lib/Home.robot

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
Open And Close WebUI Homepage
    [Tags]                                                                      WebUI_Login    WebUI
    [Documentation]                                                             Open And Close WebUI Homepage
    #[Setup]                                                                     Any Presetup
    Open Webui
    Sleep   5 seconds
    Close All Browsers


Successful Login With RememberMe
    [Tags]         WebUI_Login  ValidLogin
    [Documentation]   Successfully logging in and selecting Remember Me checkbox
    Open Webui
    Proceed To Login Page
    Fill Login Form With RememberMe       ${test_data}[login][valid_mailid]   ${test_data}[login][valid_password]
    Click Login Button


Successful Login Without RememberMe
    [Tags]         WebUI_Login    ValidLogin
    [Documentation]   Successfully logging in without selecting Remember Me checkbox
    Open Webui
    Proceed To Login Page
    Fill Login Form Without RememberMe    ${test_data}[login][valid_mailid]   ${test_data}[login][valid_password]
    Click Login Button
    Verify Login Success

Unsuccessful Login With Valid Mailid And Invalid Password
    [Tags]        WebUI_Login    InvalidLogin  InvalidLoginRegisteredCredentials
    [Documentation]       Invalid logging in With Valid Mail ids And Invalid Password
    Open Webui
    Proceed To Login Page

    ${invalid_passwords}=            Get Test Data    login    invalid_password
    ${len_invalid_passwords}=        Get Length    ${invalid_passwords}

    FOR   ${i}    IN RANGE   ${len_invalid_passwords}
        Fill Login Form With RememberMe       ${test_data}[login][valid_mailid]    ${invalid_passwords}[${i}]
        Click Login Button
        Verify Incorrect Credentials Error Message
    END

Unsuccessful Login With Unregistered Credentials
    [Tags]        WebUI_Login    InvalidLogin  InvalidLoginUnregisteredCredentials
    [Documentation]       Invalid logging in With Unregistered Credentials
    Open Webui
    Proceed To Login Page
    ${invalid_emails}=              Get Test Data    login    invalid_emailid
    ${len_invalid_emails}=          Get Length    ${invalid_emails}


    FOR   ${i}    IN RANGE   ${len_invalid_emails}
        Fill Login Form With RememberMe       ${invalid_emails}[${i}]    ${test_data}[login][valid_password]
        Click Login Button
        Verify No Cutomer Found Error Message
    END

Unsuccessful Login With Empty Parameters
    [Tags]        WebUI_Login    InvalidLogin  InvalidLoginEmptyParameters
    [Documentation]       Invalid logging in With empty Parameters
    Open Webui
    Proceed To Login Page
    #Fill Login Form With RememberMe
    Click Login Button
    Verify Enter Email Error Message

Unsuccessful Login With Wrong Mail
    [Tags]        WebUI_Login    InvalidLogin  InvalidLoginWrongMail
    [Documentation]       Invalid logging in with wrong email ids
    Open Webui
    Proceed To Login Page
    ${wrong_emails}=              Get Test Data    login    wrong_mails
    ${len_wrong_emails}=          Get Length    ${wrong_emails}

    FOR   ${i}    IN RANGE   ${len_wrong_emails}
        Fill Login Form With RememberMe       ${wrong_emails}[${i}]    ${test_data}[login][valid_password]
        Click Login Button
        Verify Wrong Email Error Message
    END


*** Keywords ***
