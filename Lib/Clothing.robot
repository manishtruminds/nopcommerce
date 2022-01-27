*** Settings ***
Library    SeleniumLibrary
Variables   ${EXECDIR}/Variables/webelement.yaml

*** Keywords ***
View By Grid
    [Documentation]   To view the records in grid view

    ${class}=  Get Element Attribute    ${clothing.grid}    class
    Should Be Equal As Strings    ${class.strip()}    viewmode-icon grid
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Click Element       ${clothing.grid}

    Element Attribute Value Should Be    ${clothing.grid}    class    viewmode-icon grid selected
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain Element    //div[@class='product-grid']

View By List
    [Documentation]   To view the records in list view

    ${class}=  Get Element Attribute    ${clothing.list}    class
    Should Be Equal As Strings    ${class.strip()}    viewmode-icon list

    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Click Element       ${clothing.list}

    Element Attribute Value Should Be    ${clothing.list}    class    viewmode-icon list selected
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...      Page Should Contain Element    //div[@class='product-list']

Enter Add To Cart
    [Documentation]   Clicking Add To cart button

    Wait Until Element Is Visible    ${clothing}[add_to_cart_btn]  timeout=10
    Click Button    ${clothing}[add_to_cart_btn]
    Sleep    3

Select Item
    [Documentation]   To select an item with given product id
    [Arguments]     ${product_id}

    Wait Until Element Is Visible    //div[@data-productid=${product_id}]//div[@class='picture']  timeout=10
    Click Element    //div[@data-productid=${product_id}]//div[@class='picture']

Select Size Option
    [Documentation]     Select size from dropdown list
    [Arguments]   ${size}  ${name}

    Wait Until Keyword Succeeds    5times    10seconds
    ...    Select From List By Label    name:${name}    ${size}
    Wait Until Keyword Succeeds    2times    10seconds
    ...    Element Should Contain    ${name}    ${size}

Verify No Size Error
    [Documentation]     Verifying that "size is not selected" error message is visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[size_error]

Verify Successful Addition
    [Documentation]     Verifying that item is successfully added to cart

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[success_message]

Verify Positive Quantity Error
    [Documentation]     Verifying that "Positive Quantity" Error message is Visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[postive_quantity_error]

Verify Enter Text Error Message
    [Documentation]     Verifying that "Enter Text Error" message is Visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[empty_textbox_error]

Enter Quantity
    [Documentation]   Enter number of items to be added to cart
    [Arguments]   ${count}

    Wait Until Element Is Visible    ${clothing}[quantity_box]  timeout=10
    Input Text    ${clothing}[quantity_box]    ${count}

Add Clothes
    [Documentation]     Add Clothes according to the product name
    [Arguments]   ${title}    ${count}=1     ${custom_text}=None   ${size}=None

    IF  "${title}" == "Custom T-Shirt"
        Add Custom Tshirt    ${custom_text}   ${count}
    ELSE IF  "${title}" == "Nike Tailwind Loose Short-Sleeve Running Shirt"
        Add Nike Shirt  ${size}  ${count}
    END

Add Custom Tshirt
    [Documentation]   Adding Custom tshirt into the cart
    [Arguments]      ${custom_text}   ${count}=1

    Select Item    ${clothing}[custom_tshirt][productid]

    Wait Until Keyword Succeeds    5 times  10seconds
    ...         Page Should Contain    Custom T-Shirt

    IF    "${custom_text}" != "None"
        Wait Until Element Is Visible    ${clothing}[custom_tshirt][text]  timeout=10
        Input Text    ${clothing}[custom_tshirt][text]    ${custom_text}
    END
    Enter Quantity    ${count}
    Sleep    3
    Enter Add To Cart

Add Nike Shirt
    [Documentation]   Adding Nike Tailwind Loose Short-Sleeve Running Shirt into the Cart
    [Arguments]   ${size}=None   ${count}= 1

    Select Item    ${clothing}[nike_shirt][productid]
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain    Nike Tailwind Loose Short-Sleeve Running Shirt

    IF   "${size}" != "None"
        Select Size Option    ${size}   ${clothing}[nike_shirt][size_selector]
    END
    Enter Quantity    ${count}
    Sleep    3
    Enter Add To Cart
