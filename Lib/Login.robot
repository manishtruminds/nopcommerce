***Settings***
Library                                                                         SeleniumLibrary
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
***Variables***
***Keywords***
Enter Username
    [Documentation]     Enter the username into textbox
    [Arguments]     ${username}= None
    Wait Until Element Is Visible    ${login}[email]  timeout=10
    Input Text  ${login}[email]    ${username}

Enter Password
    [Documentation]     Enter the password into textbox
    [Arguments]     ${password}= None
    Wait Until Element Is Visible    ${login}[password]  timeout=10
    Input Text  ${login}[password]    ${password}

Select RememberMe
    [Documentation]     Select checkbox to remember the account
    [Arguments]
    Wait Until Element Is Visible    ${login}[rememberme]  timeout=10
    Select Checkbox    ${login}[rememberme]

Unselect RememberMe
    [Documentation]     Unselect checkbox to remember the account
    [Arguments]
    Unselect Checkbox    ${login}[rememberme]

Click Login Button
    [Documentation]     Clicking the Login button
    [Arguments]
    Click Button     ${login}[login_button]

Verify Login Success
    [Documentation]     Verifying that Login is Successful
    Wait Until Keyword Succeeds    3 times  10 seconds      Page Should Contain Link    ${home}[logout]

Verify Incorrect Credentials Error Message
    [Documentation]     Verifying that the credentials entered are incorrect
    Wait Until Keyword Succeeds    3 times  10 seconds    Page Should Contain    Login was unsuccessful. Please correct the errors and try again.The credentials provided are incorrect

Verify No Cutomer Found Error Message
    [Documentation]     Verifying that no customer with given credentials exist
    Wait Until Keyword Succeeds    3 times  10 seconds    Page Should Contain    Login was unsuccessful. Please correct the errors and try again.No customer account found

Verify Enter Email Error Message
    [Documentation]     Verifying that Enter Email error message is shown
    Wait Until Keyword Succeeds    3 times  10 seconds    Page Should Contain    Please enter your email

Verify Wrong Email Error Message
    [Documentation]     Verifying that wrong mail error message is shown
    Wait Until Keyword Succeeds    3 times  10 seconds    Page Should Contain    Wrong email

Fill Login Form With RememberMe
    [Documentation]     Filling Details in login Form and selecting Remember Me checkbox
    [Arguments]     ${username}= None     ${password}= None
    Enter Username    ${username}
    Enter Password    ${password}
    Select RememberMe

Fill Login Form Without RememberMe
    [Documentation]     Filling Details in login Form and not selecing Remember Me checkbox
    [Arguments]     ${username}= None     ${password}= None
    Enter Username    ${username}
    Enter Password    ${password}
