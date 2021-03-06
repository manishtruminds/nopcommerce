*** Settings ***
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
Resource                                                                        ${EXECDIR}/Lib/Login.robot
Resource                                                                        ${EXECDIR}/Lib/Register.robot
Resource                                                                        ${EXECDIR}/Lib/Home.robot
Resource                                                                        ${EXECDIR}/Lib/Apparel.robot
Resource                                                                        ${EXECDIR}/Lib/Clothing.robot
Resource                                                                        ${EXECDIR}/Lib/Cart.robot
Resource                                                                        ${EXECDIR}/Lib/Shoes.robot

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
${browser}    ${env_variables}[${ENV_TYPE}][browser]
${url}    ${env_variables}[${ENV_TYPE}][url]
${p}    0

*** Test Cases ***
Add Custom Shirt Remove And Checkout
    [Tags]    Clothes   WebUI     WebUI_Cart
    [Documentation]   The custom T-shirt is added and removed after which we just checkout.
    Open Webui    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Custom T-Shirt   custom_text=My New Shirt
    Proceed To Shopping Cart
    Check Item In Cart    Custom T-Shirt  custom_text=My New Shirt    count=1
    Remove Item From Cart   Custom T-Shirt
    Check If Cart Is empty
    Close All Browsers

Add Adidas Shoes Into Cart And Choose Giftwrap Option
    [Documentation]   Adding adidas shoes to cart and choosing gift wrap Option.
    [Tags]    Shoes  Adidas_Shoes    gift_wrap     WebUI    WebUI_Cart
    Open Webui    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=9
    Proceed To Shopping Cart
    Check Item In Cart    adidas    size=9    color=Red   count=1
    Choose Giftwrap Option As Yes
    Verify Gift Wrap Option As Yes
    Select Term And Conditions
    Click Checkout Button    No
    Close All Browsers


Add Nike Zoom Shoes And Estimate Shipping Without Country Or Zipcode
    [Tags]    Shoes   Nike_Shoes_Zoom   WebUI   WebUI_Cart    new
    [Documentation]   Add Nike Zoom shoes and estimate shipping without entering country or zipcode details.
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    title=Nike SB Zoom Stefan Janoski    count=1
    Proceed To Shopping Cart
    Check Item In Cart   Nike SB Zoom Stefan Janoski    count=1
    Click Estimate Shipping Button
    Click Apply Estimate Button
    Check Zipcode Error
    Check Country Error
    Close All Browsers




Add Nike Floral Shoes And Continue Shopping
    [Tags]    Shoes   Nike_Shoes    WebUI   WebUI_Cart
    [Documentation]   Add Nike Floral Shoes  and click on continue shopping.Checks whether it is Shoes page as that was the last visited page.
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=White/Blue     size=9   print=Fresh
    Proceed To Shopping Cart
    Check Item In Cart    Nike Floral Roshe Customized Running Shoes    size=9    print=Fresh   count=1
    Click Continue Shopping Button
    Check If Shoes Page
    Close All Browsers

Add Nike Tailwind Shirt And Change Quantity To 3
    [Tags]    Clothes   Fail   WebUI     WebUI_Cart
    [Documentation]   Add Nike Tailwind shirt and change the quantity to 3 and checkout.
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=1X
    Proceed To Shopping Cart
    Check Item In Cart    Nike Tailwind Loose Short-Sleeve Running Shirt    count=1
    Change Quantity    Nike Tailwind Loose Short-Sleeve Running Shirt   3
    Check Item In Cart    Nike Tailwind Loose Short-Sleeve Running Shirt    count=3
    Close All Browsers

Add Adidas Shoes To Cart And Change Quantity To Minus Three
    [Documentation]   Add Adidas shoes to cart and change the quantity to minus three.Error saying required quantity is zero should be shown on the page.
    [Tags]    Shoes   Adidas_Shoes    negative_number   WebUI     WebUI_Cart
    Open Webui    ${browser}    ${url}
    Maximize Browser Window
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=9
    Proceed To Shopping Cart
    Check Item In Cart    adidas    size=9    color=Red   count=1
    Change Quantity    adidas Consortium Campus 80s Running Shoes   -3
    Check Quantity Error
    Close All Browsers

Add Nike Zoom Shoes To Cart And Change Quantity To Zero
    [Documentation]   Add Nike Zoom shoes to cart and change the quantity to zero.Item is removed from cart.
    [Tags]    Shoes   Nike_Shoes_Zoom   zero   WebUI     WebUI_Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    title=Nike SB Zoom Stefan Janoski    count=1
    Proceed To Shopping Cart
    Check Item In Cart   Nike SB Zoom Stefan Janoski    count=1
    Change Quantity    Nike SB Zoom Stefan Janoski    0
    Check If Cart Is empty
    Close All Browsers
