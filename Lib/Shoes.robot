*** Settings ***
Resource    ${EXECDIR}/Lib/Clothing.robot
Library    SeleniumLibrary
Variables   ${EXECDIR}/Variables/webelement.yaml

*** Keywords ***
Add Shoes
    [Documentation]     Add Shoes according to the product name
    [Arguments]   ${title}    ${count}=1     ${square_color}=None   ${size}=None   ${print}=None    ${list_color}=None

    IF  "${title}" == "adidas Consortium Campus 80s Running Shoes"
        Add Adidas Shoes    ${size}   ${square_color}  ${count}
    ELSE IF  "${title}" == "Nike Floral Roshe Customized Running Shoes"
        Add Nike Floral Shoes  ${size}  ${list_color}    ${print}  ${count}
    ELSE IF  "${title}" == "Nike SB Zoom Stefan Janoski"
        Add Nike Zoom Shoes   ${count}
    END

Add Adidas Shoes
    [Documentation]     Add Adidas Shoes into the cart
    [Arguments]      ${size}   ${square_color}     ${count}

    Select Item    adidas Consortium Campus 80s Running Shoes
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain    adidas Consortium Campus 80s Running Shoes

    IF   "${size}" != "None"
        Select Size Option    ${size}    ${shoes}[adidas_shoes][size_selector]
    END
    IF  "${square_color}" != "None"
        Select Square Color  ${square_color}
    END
    Enter Quantity    ${count}
    Sleep    3
    Click Add to Cart Button

Add Nike Floral Shoes
    [Documentation]     Add Nike Floral Shoes into the cart
    [Arguments]      ${size}   ${list_color}     ${print}     ${count}

    Select Item    Nike Floral Roshe Customized Running Shoes
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain     Nike Floral Roshe Customized Running Shoes


    IF   "${size}" != "None"
        Select Size Option    ${size}    ${shoes}[nike_floral_shoes][size_selector]
    END
    IF  "${list_color}" != "None"
        Select List Color    ${list_color}
    END
    IF  "${print}" != "None"
        Select Print Option   ${print}
    END
    Enter Quantity    ${count}
    Sleep    3
    #Click Element    //div[class='master-wrapper-page']
    Mouse Out     ${shoes}[nike_floral_shoes][fresh_print]
    #Mouse Over    ${clothing}[add_to_cart_btn]
    Click Add to Cart Button

Add Nike Zoom Shoes
    [Documentation]     Add Nike Zoom Shoes into the cart
    [Arguments]      ${count}

    Select Item    Nike SB Zoom Stefan Janoski
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain     Nike SB Zoom Stefan Janoski "Medium Mint"

    Enter Quantity    ${count}
    Sleep    3
    Click Add to Cart Button

Select List Color
    [Documentation]   Selecting Color from dropdown menu
    [Arguments]   ${list_color}

    Wait Until Keyword Succeeds    5times    10seconds
    ...    Select From List By Label    name:${shoes}[nike_floral_shoes][color_selector]    ${list_color}
    Wait Until Keyword Succeeds    2times    10seconds
    ...    Element Should Contain    ${shoes}[nike_floral_shoes][color_selector]    ${list_color}

Select Print Option
    [Documentation]     Select print of shoes
    [Arguments]     ${print}

    IF  "${print}" == "Natural"
        Select Natural Print
    ELSE
        Select Fresh Print
    END

Select Natural Print
    [Documentation]   Selecting Natural print of shoes
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Element    ${shoes}[nike_floral_shoes][natural_print]
    Element Attribute Value Should Be    ${shoes}[nike_floral_shoes][natural_print]    class    selected-value

Select Fresh Print
    [Documentation]     Selecting Fresh print of shoes

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...   Click Element    ${shoes}[nike_floral_shoes][fresh_print]
    Element Attribute Value Should Be    ${shoes}[nike_floral_shoes][fresh_print]    class    selected-value

Select Square Color
    [Documentation]   Selecting color from square images boxes
    [Arguments]     ${square_color}

    IF  "${square_color}" == "Red"
        Select Red Color
    ELSE IF  "${square_color}" == "Blue"
        Select Blue Color
    ELSE
        Select Silver Color
    END

Select Red Color
    [Documentation]   Selecting Red Color from square color box

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Element    ${shoes}[adidas_shoes][red_color]
    Element Attribute Value Should Be   ${shoes}[adidas_shoes][red_color]/ancestor::li    class    selected-value

Select Blue Color
    [Documentation]   Selecting Blue Color from square color box

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Element    ${shoes}[adidas_shoes][blue_color]
    Element Attribute Value Should Be   ${shoes}[adidas_shoes][blue_color]/ancestor::li    class    selected-value

Select Silver Color
    [Documentation]   Selecting Silver Color from square color box

    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Element    ${shoes}[adidas_shoes][silver_color]
    Element Attribute Value Should Be   ${shoes}[adidas_shoes][silver_color]/ancestor::li    class    selected-value

Verify No Color Error
    [Documentation]     Verifying "no color is selected" error message is visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${shoes}[no_color_error]

Verify No Print Error
    [Documentation]     Verifying "no print is selected" error is visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${shoes}[no_print_error]
