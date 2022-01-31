*** Settings ***
Library     SeleniumLibrary
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Home.robot
Resource    ../Lib/Apparel.robot
Resource    ../Lib/Clothing.robot
Resource    ../Lib/Shoes.robot

Variables    ${EXECDIR}/Variables/webelement.yaml

Documentation    This resource file contains keywords for dealing with the Shopping cart page
*** Keywords ***
Check Item In Cart
    [Documentation]   checks if item is present in the cart.expected_item is the name of the product seen in the cart    count size add
    [Arguments]       ${expected_item}
    Page Should Contain    Shopping cart
    Wait Until Element Is Visible    ${shopping_cart}[cart_table]
    Table Column Should Contain    ${shopping_cart}[cart_table]    3    ${expected_item}

 Click Checkout Button
    [Arguments]   ${signed_in}
    [Documentation]   Pass Yes if signed in No if not signed in
    Wait Until Element Is Enabled     ${shopping_cart}[checkout]
    Click Button    ${shopping_cart}[checkout]
    Run Keyword If    '${signed_in}'=='Yes'    Page Should Contain   Billing address
    ...   ELSE    Page Should Contain    Checkout as a guest


Select Term And Conditions
    Wait Until Element Is Enabled    ${shopping_cart}[terms_and_conditions]
    Click Element    ${shopping_cart}[terms_and_conditions]
    Wait Until Keyword Succeeds    2    10seconds   Checkbox Should Be Selected    ${shopping_cart}[terms_and_conditions]

Choose Giftwrap Option
    [Arguments]   ${option}
    Wait Until Element Is Enabled    ${shopping_cart}[gift_wrap_dropdown]
    Run Keyword If    '${option}'=='Yes'   Select From List By Value    ${shopping_cart}[gift_wrap_dropdown]    2
    ...   ELSE IF     '${option}'=='No'    Select From List By Value    ${shopping_cart}[gift_wrap_dropdown]    1

Verify Gift Wrap option
    [Arguments]   ${option}
    Run Keyword If    '${option}'=="Yes"
    ...    Wait Until Keyword Succeeds    2    10 seconds
    ...    Page Should Contain    Gift wrapping: Yes [+$10.00]
    ...   ELSE IF   '${option}'=='No'
    ...   Wait Until Keyword Succeeds    2    10seconds    Page Should Contain    Gift wrapping: No
