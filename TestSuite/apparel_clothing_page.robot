
*** Settings ***
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
Resource                                                                        ${EXECDIR}/Lib/Login.robot
Resource                                                                        ${EXECDIR}/Lib/Register.robot
Resource                                                                        ${EXECDIR}/Lib/Home.robot
Resource                                                                        ${EXECDIR}/Lib/Apparel.robot
Resource                                                                        ${EXECDIR}/Lib/Clothing.robot
Resource                                                                        ${EXECDIR}/Lib/Shoes.robot
Resource                                                                        ${EXECDIR}/Lib/Checkout.robot
Resource                                                                        ${EXECDIR}/Lib/Cart.robot

Library                                                                         SeleniumLibrary
Library                                                                         DependencyLibrary
Library                                                                         OperatingSystem
Library                                                                         DateTime
Library                                                                         String
Library                                                                         Collections
Library                                                                         SSHLibrary


Variables                                                                       ${EXECDIR}/Variables/env.yaml
Variables                                                                       ${EXECDIR}/Variables/webelement.yaml
Variables                                                                       ${EXECDIR}/Variables/testdata.yaml

*** Variables ***
# Device test variables
${browser}                                  ${env_variables}[${ENV_TYPE}][browser]
${url}                                      ${env_variables}[${ENV_TYPE}][url]

*** Test Cases ***

Displaying Clothes In List View And Grid View
    [Tags]    WebUI_Clothing    Different_Views   TC1
    [Documentation]   Toggling between Displaying records as list and grid
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    View By List
    Sleep    3
    View By Grid
    Sleep    3

    Close All Browsers

Successfully Adding Custom T-Shirt into cart
    [Tags]    WebUI_Clothing    Successful_Addition   TC2
    [Documentation]   Successfully adding Custom T-shirt into the Cart

    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    ${price}=  Add Clothes    Custom T-Shirt   custom_text=My New Shirt    count=3

    Verify Successful Addition
    Proceed To Shopping Cart
    Check Item In Cart    Custom T-Shirt    custom_text=My New Shirt
    #checking cart value is correct
    ${price_str}=    Get Total Cart Value
    ${expected_price} =	 Get Substring	  ${price_str}    1
    Convert To Number    ${expected_price}
    Should Be Equal As Numbers    ${price}    ${expected_price}

    Close All Browsers

Successfully Adding Nike T-Shirt into cart
    [Tags]    WebUI_Clothing    Successful_Addition    TC3
    [Documentation]   Successfully adding Nike T-shirt into the Cart

    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    ${price}=  Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=1X
    Verify Successful Addition
    Proceed To Shopping Cart
    Check Item In Cart    Nike Tailwind Loose Short-Sleeve Running Shirt    size=1X

    #checking cart value is correct
    ${price_str}=    Get Total Cart Value
    ${expected_price} =	 Get Substring	  ${price_str}    1
    Convert To Number    ${expected_price}
    Should Be Equal As Numbers    ${price}    ${expected_price}

    Close All Browsers

Successfully Adding Many Clothes into cart

    [Tags]    WebUI_Clothing    Successful_Addition   TC4
    [Documentation]   Successfully adding clothes into the Cart

    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    ${price1}=  Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=1X  count=3
    Verify Successful Addition
    Go Back
    ${price2}=   Add Clothes    Custom T-Shirt   custom_text=My New Shirt  count=2
    Verify Successful Addition
    Sleep    3
    #Check Correct Items Are In Cart
    Proceed To Shopping Cart
    Check Item In Cart    Nike Tailwind Loose Short-Sleeve Running Shirt    size=1X
    Check Item In Cart    Custom T-Shirt    custom_text=My New Shirt  count=2
    ${total}=   Evaluate    ${price1} + ${price2}
    #checking cart value is correct
    ${price_str}=    Get Total Cart Value
    ${expected_price} =	 Get Substring	  ${price_str}    1
    Convert To Number    ${expected_price}
    Should Be Equal As Numbers    ${total}    ${expected_price}

    Close All Browsers

Empty Custom TextBox
    [Tags]    WebUI_Clothing   Unsuccessful_Addition   EmptyCustomTextbox  TC5
    [Documentation]   Unsuccessful in adding clothes into the Cart due to empty custom textbox error

    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Custom T-Shirt
    Verify Enter Text Error Message
    Sleep    3
    Close All Browsers

Empty Size Option
    [Tags]    WebUI_Clothing   Unsuccessful_Addition   EmptySize    TC6
    [Documentation]   Unsuccessful in adding clothes into the Cart due to empty size textbox error

    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt
    Verify No Size Error
    Sleep    3
    Close All Browsers

Negative Count Error
    [Tags]    WebUI_Clothing   Unsuccessful_Addition   NegativeCountError   TC7
    [Documentation]   Unsuccessful in adding clothes into the Cart due to negative or zero count of items

    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   count=0   size=Small
    Verify Positive Quantity Error
    Go Back
    Add Clothes    Custom T-Shirt   custom_text=Hie  count=-1
    Verify Positive Quantity Error
    Sleep    3
    Close All Browsers
