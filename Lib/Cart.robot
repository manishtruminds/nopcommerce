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
${displayed_count}    -1
${remove_button}    ""
${count_input}    ""
${price}    0
*** Keywords ***
Check Item In Cart
    [Documentation]   Checks if item is present in the cart.${expected_item} is the name of the product seen in the cart.
    ...    ${count} is the count of ${expected_item} in the cart.${custom text} is the custom text if custom shirt is ${expected_item}
    ...    ${size} is the size of ${expected_item}. ${color} is the color of ${expected_item}
    ...    ${print} is the print if Nike Floral Shoes is the ${expected_item}
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
        ${count_input}=   Replace String    ${shopping_cart}[count_input]   PLACEHOLDER_REPLACE_ME    ${expected_item}
        Wait Until Keyword Succeeds    2    10 seconds
        ...   Element Should Be Enabled     ${count_input}
        ${displayed_count}    Get Value    ${count_input}
        Log To Console    ${displayed_count}
        Should Be Equal    ${count}    ${displayed_count}
    END

Check If Cart Is empty
    [Documentation]   Checks if the cart is empty
    Wait Until Keyword Succeeds    2 times    10 seconds
    ...   Page Should Contain    Your Shopping Cart is empty!

Click Estimate Shipping Button
    [Documentation]   Clicks the estimate shipping button
    Wait Until Element Is Enabled    ${shopping_cart}[estimate_shipping]
    Click Element   ${shopping_cart}[estimate_shipping]

Click Apply Estimate Button
    [Documentation]   Clicks the apply estimate button in the estimate shipping window
    Wait Until Element Is Enabled    ${shopping_cart}[apply_estimate_shipping]
    Click Element    ${shopping_cart}[apply_estimate_shipping]

Click Checkout Button
    [Documentation]   Clicks on the Checkout button.Pass Yes if signed in No if not signed in for ${signed_in}
    [Arguments]   ${signed_in}
    Wait Until Element Is Enabled     ${shopping_cart}[checkout]
    Click Button    ${shopping_cart}[checkout]
    IF    '${signed_in}'=='Yes'
        Page Should Contain   Billing address
    ELSE
        Page Should Contain    Checkout as a guest
    END

Click Continue Shopping Button
    [Documentation]   Clicks on the continue shopping button
    Wait Until Element Is Enabled    ${shopping_cart}[continue_shopping]
    Click Button    ${shopping_cart}[continue_shopping]

Check If Shoes Page
    [Documentation]   Check if the current page is the page showing the different shoes
    Wait Until Keyword Succeeds    2 times    30 seconds
    ...   Page Should Contain Element    ${shoes}[shoes_header]


Select Term And Conditions
    [Documentation]   Selects the terms and conditions checkbox
    Wait Until Element Is Enabled    ${shopping_cart}[terms_and_conditions]
    Click Element    ${shopping_cart}[terms_and_conditions]
    Wait Until Keyword Succeeds    2    10seconds   Checkbox Should Be Selected    ${shopping_cart}[terms_and_conditions]

Choose Giftwrap Option As Yes
    [Documentation]   Chooses the gift wrap option from the drop down as yes
    Wait Until Element Is Enabled    ${shopping_cart}[gift_wrap_dropdown]
    Select From List By Value    ${shopping_cart}[gift_wrap_dropdown]    2

Choose Giftwrap Option As No
    [Documentation]   Chooses the gift wrap option from the drop down as no
    Wait Until Element Is Enabled    ${shopping_cart}[gift_wrap_dropdown]
    Select From List By Value    ${shopping_cart}[gift_wrap_dropdown]    1

Verify Gift Wrap Option As Yes
     [Documentation]   Checks if the gift wrap option is Yes
     Wait Until Keyword Succeeds    2    10 seconds
    ...    Page Should Contain    Gift wrapping: Yes [+$10.00]

Verify Gift Wrap Option As No
    [Documentation]   Checks if the gift wrap option is No
    Wait Until Keyword Succeeds    2    10seconds
    ...   Page Should Contain    Gift wrapping: No

Change Quantity
    [Documentation]   Changes the quantity of the product to ${qty} whose item name is ${item_name}
    [Arguments]   ${item_name}    ${qty}
    ${count_input}    Replace String    ${shopping_cart}[count_input]   PLACEHOLDER_REPLACE_ME    ${item_name}
    Wait Until Keyword Succeeds    2 times    10 seconds
    ...   Element Should Be Enabled    ${count_input}
    Input Text    ${count_input}    ${qty}  clear=True
    Wait Until Keyword Succeeds    2 times      10 seconds
    ...   Element Should Be Enabled    ${shopping_cart}[update_cart]
    Click Element    ${shopping_cart}[update_cart]

Remove Item From Cart
    [Documentation]   Removes an item from the cart after being passed the name of the product.
    [Arguments]   ${product_name}
    ${remove_button}=    Replace String    ${shopping_cart}[remove_button]   PLACEHOLDER_REPLACE_ME    ${product_name}
    Wait Until Keyword Succeeds    2 times    10 seconds
    ...   Click Element    ${remove_button}

Check Quantity Error
    [Documentation]   Checks if the error :This product is required in the quantity of 0 is present on the page
    Wait Until Keyword Succeeds    2 times    10 seconds
    ...   Page Should Contain Element    ${shopping_cart}[quantity_error]

Get Total Cart value
    [Documentation]   Gets the total price of all the items in the card_type
    Wait Until Keyword Succeeds    2 times    10 seconds
    ...   Page Should Contain Element    ${shopping_cart}[total_price]
    ${price}    Get Text    ${shopping_cart}[total_price]
    Return From Keyword    ${price}
