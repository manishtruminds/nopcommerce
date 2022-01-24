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

    Select Item    ${shoes}[adidas_shoes][productid]
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain    adidas Consortium Campus 80s Running Shoes


    IF   "${size}" != "None"
        Select Size Option    ${size}    ${shoes}[adidas_shoes][size_selector]
        IF  "${square_color}" != "None"
            Select Square Color  ${square_color}
        END
        #Count
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
        Verify No Size Error
    END

Add Nike Floral Shoes
    [Documentation]     Add Nike Floral Shoes into the cart
    [Arguments]      ${size}   ${list_color}     ${print}     ${count}

    Select Item    ${shoes}[nike_floral_shoes][productid]
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain     Nike Floral Roshe Customized Running Shoes

    IF   "${size}" != "None"
        Select Size Option    ${size}    ${shoes}[nike_floral_shoes][size_selector]
        IF  "${list_color}" != "None"
            Select List Color  ${list_color}
            IF  "${print}" != "None"
                Select Print Option  ${print}
                IF  ${count} < 1
                    Enter Quantity    ${count}
                    Enter Add To Cart
                    #Click Element    //button[@id='add-to-cart-button-24']
                    Verify Positive Quantity Error
                ELSE IF   ${count} > 1
                    Enter Quantity    ${count}
                    Enter Add To Cart
                    Verify Successful Addition
                END
            ELSE
                Enter Add To Cart
                Verify No Print Error
            END

        ELSE
            Enter Add To Cart
            Verify No Color Error
        END



    ELSE
        Enter Add To Cart
        Verify No Size Error
    END

Add Nike Zoom Shoes
    [Documentation]     Add Nike Zoom Shoes into the cart
    [Arguments]      ${count}

    Select Item    ${shoes}[nike_zoom_shoes][productid]
    Wait Until Keyword Succeeds    5 times  10 seconds
    ...       Page Should Contain     Nike SB Zoom Stefan Janoski "Medium Mint"

    IF  ${count} > 1
        Enter Quantity    ${count}
        Enter Add To Cart
        Verify Successful Addition
    ELSE
        Enter Quantity    ${count}
        Enter Add To Cart
        Verify Positive Quantity Error
    END


Select List Color
    [Arguments]   ${list_color}
    Wait Until Keyword Succeeds    5times    10seconds
    ...    Select From List By Label    name:${shoes}[nike_floral_shoes][color_selector]    ${list_color}
    Wait Until Keyword Succeeds    2times    10seconds
    ...    Element Should Contain    ${shoes}[nike_floral_shoes][color_selector]    ${list_color}

Select Print Option
    [Arguments]     ${print}
    IF  "${print}" == "Natural"
        Select Natural Print
    ELSE
        Select Fresh Print
    END

Select Natural Print
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Element    ${shoes}[nike_floral_shoes][natural_print]
    Element Attribute Value Should Be    ${shoes}[nike_floral_shoes][natural_print]    class    selected-value


Select Fresh Print
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...   Click Element    ${shoes}[nike_floral_shoes][fresh_print]
    Element Attribute Value Should Be    ${shoes}[nike_floral_shoes][fresh_print]    class    selected-value


Select Square Color
    [Arguments]     ${square_color}

    IF  "${square_color}" == "red"
        Select Red Color
    ELSE IF  "${square_color}" == "blue"
        Select Blue Color
    ELSE
        Select Silver Color
    END

Select Red Color
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${shoes}[adidas_shoes][color]     25
    Radio Button Should Be Set To    ${shoes}[adidas_shoes][color]      25

Select Blue Color
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button     ${shoes}[adidas_shoes][color]      26
    Radio Button Should Be Set To     ${shoes}[adidas_shoes][color]      26

Select Silver Color
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button     ${shoes}[adidas_shoes][color]      27
    Radio Button Should Be Set To     ${shoes}[adidas_shoes][color]       27


Verify No Color Error
    [Documentation]     Verifying no color is selected error is visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${shoes}[no_color_error]


Verify No Print Error
    [Documentation]     Verifying no print is selected error is visible

    Wait Until Keyword Succeeds    3 times  10 seconds
    ...     Page Should Contain Element    ${shoes}[no_print_error]
