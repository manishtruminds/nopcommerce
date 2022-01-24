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
    [Documentation]   To select an item
    [Arguments]     ${product_id}
    #select product with product id
    Wait Until Element Is Visible    //div[@data-productid=${product_id}]  timeout=10
    Click Element    //div[@data-productid=${product_id}]


Select Size Option
    [Arguments]   ${size}  ${name}

    Wait Until Keyword Succeeds    5times    10seconds
    ...    Select From List By Label    name:${name}    ${size}
    Wait Until Keyword Succeeds    2times    10seconds
    ...    Element Should Contain    ${name}    ${size}


Verify No Size Error
    [Documentation]     Verifying that size is not selected error message

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[size_error]


Verify Successful Addition
    [Documentation]     Verifying that item is added to cart

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[success_message]


Verify Positive Quantity Error
    [Documentation]     Verifying that Positive Quantity Error message is Visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[postive_quantity_error]


Verify Enter Text Error Message
    [Documentation]     Verifying that Enter Text Error message is Visible


    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[empty_textbox_error]


Enter Quantity
    [Arguments]   ${count}
    Wait Until Element Is Visible    ${clothing}[quantity_box]  timeout=10
    Input Text    ${clothing}[quantity_box]    ${count}

Add Clothes
    [Documentation]     Add Product according to the product name
    [Arguments]   ${title}    ${count}=1     ${custom_text}=None   ${size}=None


    IF  "${title}" == "Custom T-Shirt"
        Add Custom Tshirt    ${custom_text}   ${count}
    ELSE IF  "${title}" == "Nike Tailwind Loose Short-Sleeve Running Shirt"
        Add Nike Shirt  ${size}  ${count}
    END

Add Custom Tshirt
    [Documentation]   Adding Custom tshirt into cart
    [Arguments]      ${custom_text}   ${count}=1

    Select Item    ${clothing}[custom_tshirt][productid]

    Wait Until Keyword Succeeds    5 times  10seconds
    ...         Page Should Contain    Custom T-Shirt

    IF    "${custom_text}" != "None"

        Wait Until Element Is Visible    ${clothing}[custom_tshirt][text]  timeout=10
        Input Text    ${clothing}[custom_tshirt][text]    ${custom_text}

        IF  ${count} < 1
            Enter Quantity    ${count}
            Enter Add To Cart
            Verify Positive Quantity Error
        ELSE
            Enter Quantity    ${count}
            Enter Add To Cart
            Verify Successful Addition
        END
    ELSE
        Enter Add To Cart
        Verify Enter Text Error Message
    END

Add Nike Shirt
    [Documentation]   Adding Nike Tailwind Loose Short-Sleeve Running Shirt into Cart
    [Arguments]   ${size}=None   ${count}= 1

    Select Item    ${clothing}[nike_shirt][productid]
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain    Nike Tailwind Loose Short-Sleeve Running Shirt

    IF   "${size}" != "None"
        Select Size Option    ${size}   ${clothing}[nike_shirt][size_selector]
        IF   ${count} < 1
            Enter Quantity    ${count}
            Enter Add To Cart
            Verify Positive Quantity Error
        ELSE
            Enter Quantity    ${count}
            Enter Add To Cart
            Verify Successful Addition
            # verify that tem is added to the cart
        END
    ELSE
        Enter Add To Cart
        Verify No Size Error

    END
