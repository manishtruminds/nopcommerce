*** Settings ***
Library     SeleniumLibrary
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Home.robot
Resource    ../Lib/Apparel.robot
Resource    ../Lib/Clothing.robot
Resource    ../Lib/Shoes.robot

Variables    ${EXECDIR}/Variables/webelement.yaml


Documentation    This resource file contains keywords for dealing with the Shopping cart page
***Variables***

*** Keywords ***
Check Item In Cart
    [Documentation]   checks if item is present in the cart.expected_item is the name of the product seen in the cart    count size add
    [Arguments]       ${expected_item}    ${size}=Size:   ${color}=Color:    ${print}=Print:   ${custom_text}=Custom text:  ${count}=0
    Page Should Contain    Shopping cart
    IF    "${size}" != "Size:"
        ${size}    Catenate    Size:    ${size}
        Table Column Should Contain    ${shopping_cart}[cart_table]    3    ${size}
    END
    IF    "${color}" != "Color:"
        ${color}    Catenate    Color:    ${color}
        Table Column Should Contain    ${shopping_cart}[cart_table]    3    ${color}
    END
    IF    "${print}" != "Print:"
        ${print}    Catenate    Print:    ${print}
        Table Column Should Contain    ${shopping_cart}[cart_table]    3    ${print}
    END
    IF    "${custom_text}" != "Custom text:"
        ${custom_text}    Catenate    Custom Text:    ${custom_text}
        Table Column Should Contain    ${shopping_cart}[cart_table]    3    ${custom_text}
    END
    Wait Until Element Is Visible    ${shopping_cart}[cart_table]
    Table Column Should Contain    ${shopping_cart}[cart_table]    3    ${expected_item}
    IF    ${count}!=0
        Wait Until Keyword Succeeds    2    10 seconds    Page Should Contain    Qty
        ${displayed_count}   Get Text  ${shopping_cart}[count_input]
        Should Be Equal    ${count}    ${displayed_count}
    END


 


 Click Checkout Button
    [Arguments]   ${signed_in}
    [Documentation]   Pass Yes if signed in No if not signed in
    Wait Until Element Is Enabled     ${shopping_cart}[checkout]
    Click Button    ${shopping_cart}[checkout]
    Run Keyword If    '${signed_in}'=='Yes'    Page Should Contain   Billing address
    ...   ELSE    Page Should Contain    Checkout as a guest

Click Continue Shopping Button
    Wait Until Element Is Enabled    ${shopping_cart}[continue_shopping]
    Click Button    ${shopping_cart}[continue_shopping]

Check If Shoes Page
    Wait Until Keyword Succeeds    2 times    30 seconds
    ...   Page Should Contain Element    ${shoes}[shoes_header]


Select Term And Conditions
    Wait Until Element Is Enabled    ${shopping_cart}[terms_and_conditions]
    Click Element    ${shopping_cart}[terms_and_conditions]
    Wait Until Keyword Succeeds    2    10seconds   Checkbox Should Be Selected    ${shopping_cart}[terms_and_conditions]

Choose Giftwrap Option As Yes
    Wait Until Element Is Enabled    ${shopping_cart}[gift_wrap_dropdown]
    Select From List By Value    ${shopping_cart}[gift_wrap_dropdown]    2

Choose Giftwrap Option As No
    Wait Until Element Is Enabled    ${shopping_cart}[gift_wrap_dropdown]
    Select From List By Value    ${shopping_cart}[gift_wrap_dropdown]    1

Verify Gift Wrap Option As Yes
     Wait Until Keyword Succeeds    2    10 seconds
    ...    Page Should Contain    Gift wrapping: Yes [+$10.00]

Verify Gift Wrap Option As No
    Wait Until Keyword Succeeds    2    10seconds
    ...   Page Should Contain    Gift wrapping: No
