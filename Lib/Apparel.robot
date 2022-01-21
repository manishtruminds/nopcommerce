*** Settings ***
Library    SeleniumLibrary
Variables   ${EXECDIR}/Variables/webelement.yaml

*** Keywords ***
Proceed To Clothing Page
    [Documentation]   Navigating to Clothing Page
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Click Element       ${apparel}[clothing]

    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Title Should Be    nopCommerce demo store. Clothing

Proceed To Shoes Page
    [Documentation]   Navigating to Shoes Page
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Click Element   ${apparel}[shoes]

    Wait Until Keyword Succeeds    5 times  10 seconds
    ...    Title Should Be    nopCommerce demo store. Shoes
