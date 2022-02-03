
*** Settings ***
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
Resource                                                                        ${EXECDIR}/Lib/Login.robot
Resource                                                                        ${EXECDIR}/Lib/Register.robot
Resource                                                                        ${EXECDIR}/Lib/Home.robot
Resource                                                                        ${EXECDIR}/Lib/Apparel.robot
Resource                                                                        ${EXECDIR}/Lib/Clothing.robot
Resource                                                                        ${EXECDIR}/Lib/Shoes.robot
Resource                                                                        ${EXECDIR}/Lib/Cart.robot
Resource                                                                        ${EXECDIR}/Lib/Checkout.robot

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
Displaying Shoes In List View And Grid View
    [Tags]    WebUI_Shoes    Different_Views
    [Documentation]   Toggling between Displaying records as list and grid
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    View By List
    Sleep    3
    View By Grid
    Sleep    3

    Close All Browsers
Successfully Adding Adidas Shoes Into Cart
    [Tags]    WebUI_Shoes    Successful_Addition    Adidas_Shoes

    [Documentation]   Successfully adding Adidas Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    ${price}=   Add Shoes    adidas Consortium Campus 80s Running Shoes     size=9
    Verify Successful Addition
    Sleep    3
    #Check Correct Items Are In Cart
    Proceed To Shopping Cart
    Check Item In Cart    adidas Consortium Campus 80s Running Shoes    size=9

    #checking cart value is correct
    ${price_str}=    Get Total Cart Value
    ${expected_price} =	 Get Substring	  ${price_str}    1
    Convert To Number    ${expected_price}
    Should Be Equal As Numbers    ${price}    ${expected_price}

    Close All Browsers

Successfully Adding Nike Floral Shoes Into Cart
    [Tags]    WebUI_Shoes     Successful_Addition   Nike_Shoes
    [Documentation]   Successfully adding Nike Floral Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    ${price}=   Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=White/Blue     size=9   print=Fresh
    Verify Successful Addition
    Sleep    3
    #Check Correct Items Are In Cart
    Proceed To Shopping Cart
    Check Item In Cart    Nike Floral Roshe Customized Running Shoes    color=White/Blue     size=9   print=Fresh

    #checking cart value is correct
    ${price_str}=    Get Total Cart Value
    ${expected_price} =	 Get Substring	  ${price_str}    1
    Convert To Number    ${expected_price}
    Should Be Equal As Numbers    ${price}    ${expected_price}

    Close All Browsers

Successfully Adding Nike Zoom Shoes Into Cart

    [Tags]    WebUI_Shoes    Successful_Addition     Nike_Shoes_Zoom

    [Documentation]   Successfully adding Nike Zoom Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    ${price}=   Add Shoes    title=Nike SB Zoom Stefan Janoski    count=2
    Verify Successful Addition
    Sleep    3

    Proceed To Shopping Cart
    Check Item In Cart    Nike SB Zoom Stefan Janoski     count=2

    #checking cart value is correct
    ${price_str}=    Get Total Cart Value
    ${expected_price} =	 Get Substring	  ${price_str}    1
    Convert To Number    ${expected_price}
    Should Be Equal As Numbers    ${price}    ${expected_price}

    Close All Browsers

Successfully Adding Many Shoes Into Cart

    [Tags]    WebUI_Shoes    Successful_Addition    Shoes_All

    [Documentation]   Successfully adding Many Shoes into the Cart

    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page

    ${price1}=  Add Shoes    adidas Consortium Campus 80s Running Shoes   size=10    square_color=Silver
    Verify Successful Addition
    Go Back

    ${price2}=  Add Shoes    Nike Floral Roshe Customized Running Shoes   size=8    list_color=White/Black   print=Fresh
    Verify Successful Addition
    Go Back
    ${price3}=  Add Shoes    Nike SB Zoom Stefan Janoski    count=3

    ${total}=  Evaluate    ${price1} + ${price2} + ${price3}



    Verify Successful Addition
    Proceed To Shopping Cart
    Check Item In Cart    adidas Consortium Campus 80s Running Shoes    size=10    color=Silver
    Check Item In Cart    Nike Floral Roshe Customized Running Shoes    size=8     color=White/Black   print=Fresh
    Check Item In Cart    Nike SB Zoom Stefan Janoski    count=3
    #checking cart value is correct
    ${price_str}=    Get Total Cart Value
    ${expected_price} =	 Get Substring	  ${price_str}    1
    Convert To Number    ${expected_price}
    Should Be Equal As Numbers    ${total}    ${expected_price}

    Close All Browsers

No Size Error

    [Tags]    WebUI_Shoes   NoSize    Unsuccessful_Addition

    [Documentation]   Unsuccessful in adding shoes into the Cart due to empty size textbox error
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    #no size is provided
    Add Shoes    adidas Consortium Campus 80s Running Shoes
    Verify No Size Error
    Sleep    3
    Close All Browsers

No Color Error

    [Tags]    WebUI_Shoes   NoColor   Unsuccessful_Addition

    [Documentation]   Unsuccessful in adding shoes into the Cart due to no color error
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    # no color is provided
    Add Shoes     Nike Floral Roshe Customized Running Shoes   size=11   print=Natural
    Verify No Color Error
    Sleep    3
    Close All Browsers

No Print Error
    [Tags]    WebUI_Shoes   NoPrint   Unsuccessful_Addition

    [Documentation]   Unsuccessful in adding shoes into the Cart due to no color error
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    # no print is provided
    Add Shoes     Nike Floral Roshe Customized Running Shoes   size=11   list_color=White/Blue
    Verify No Print Error
    Sleep    3
    Close All Browsers

Zero OR Negative Count Error

    [Tags]    WebUI_Shoes   ZeroCount    Unsuccessful_Addition

    [Documentation]   Unsuccessful in adding shoes into the Cart due to no color error
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    # 0 count is provided
    Add Shoes     Nike Floral Roshe Customized Running Shoes
    ...    size=11   print=Natural    list_color=White/Blue    count=0
    Verify Positive Quantity Error
    Sleep    3
    Close All Browsers
