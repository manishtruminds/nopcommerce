*** Settings ***
Library    SeleniumLibrary
Variables   ${EXECDIR}/Variables/webelement.yaml

*** Keywords ***
Proceed To Register Page
    [Documentation]    Navigate the browser to nopCommerce registration page
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Link    ${home}[register]

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Register

Proceed To Login Page
    [Documentation]   Moving to Login Page
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Click Link  ${home}[login]

    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Title Should Be    nopCommerce demo store. Login


Proceed To Apparel Page
    [Documentation]   Navigating to Apparel Page
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Click Link  ${home}[apparel]

    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Title Should Be    nopCommerce demo store. Apparel
