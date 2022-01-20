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
