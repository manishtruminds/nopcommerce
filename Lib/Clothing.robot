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
    #validation that list is now showing by grid  :-- no idea

View By List
    [Documentation]   To view the records in list view

    ${class}=  Get Element Attribute    ${clothing.list}    class
    Should Be Equal As Strings    ${class.strip()}    viewmode-icon list

    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Click Element       ${clothing.list}

    Element Attribute Value Should Be    ${clothing.list}    class    viewmode-icon list selected

Enter Add To Cart
    [Documentation]   Clicking Add To cart button
    Wait Until Element Is Visible    ${clothing}[custom_tshirt][add_to_cart_btn]  timeout=10
    Click Button    ${clothing}[custom_tshirt][add_to_cart_btn]
    Sleep    3

Select Clothing Item
    [Documentation]   To select an item
    [Arguments]     ${product_id}  ${size}= None   ${count}= 1  ${custom_text}= None
    #select product with product id
    Wait Until Element Is Visible    //div[@data-productid=${product_id}]  timeout=10
    Click Element    //div[@data-productid=${product_id}]



Add Custom Tshirt
    [Documentation]   Adding Custom tshirt into cart
    [Arguments]      ${count}= 1     ${custom_text}= None
    Select Clothing Item    ${clothing}[custom_tshirt][productid]   ${count}   custom_text:${custom_text}
    IF    "${custom_text}" != None
        Wait Until Element Is Visible    ${clothing}[custom_tshirt][text]  timeout=10
        Input Text    ${clothing}[custom_tshirt][text]    ${custom_text}
        IF  ${count}==0
            Wait Until Element Is Visible    ${clothing}[custom_tshirt][quantity_box]  timeout=10
            Input Text    ${clothing}[custom_tshirt][quantity_box]    ${count}
            Verify Positive Quantity Error
        ELSE IF  ${count} > 1
            Wait Until Element Is Visible    ${clothing}[custom_tshirt][quantity_box]  timeout=10
            Input Text    ${clothing}[custom_tshirt][quantity_box]    ${count}
        END
        Enter Add To Cart
        Verify Successful Addition
    ELSE
        Verify Enter Text Error Message
    END

Verify Successful Addition
    [Documentation]     Verifying that item is added to car
    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[custom_tshirt][success_message]



Verify Positive Quantity Error
    [Documentation]     Verifying that Positive Quantity Error message is Visible
    Enter Add To Cart
    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[custom_tshirt][postive_quantity_error]


Verify Enter Text Error Message

    [Documentation]     Verifying that Enter Text Error message is Visible
    Enter Add To Cart
    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${clothing}[custom_tshirt][empty_textbox_error]
