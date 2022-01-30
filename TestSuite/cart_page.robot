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

*** Test Cases ***
Add Custom Shirt Remove And Checkout
    [Documentation]   The custom T-shirt is added and removed after which we just checkout.This test case will fail as terms and conditions are not agreed to.
    Open Webui    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Custom T-Shirt   custom_text=My New Shirt
    Proceed To Shopping Cart
    Check Item In Cart    Custom T-Shirt  custom_text=My New Shirt
    Select Term And Conditions
    Click Checkout Button    No
    Close All Browsers

Add Adidas Shoes Into Cart And Choose Giftwrap Option
    [Documentation]   Adding adidas shoes to cart and choosing gift wrap Option
    [Tags]    Shoes  Adidas_Shoes
    Open Webui    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=9
    Proceed To Shopping Cart
    Check Item In Cart    adidas    size=9    color=Red
    Choose Giftwrap Option As Yes
    Verify Gift Wrap Option As Yes
    Select Term And Conditions
    Click Checkout Button    No
    Close All Browsers

Successfully Adding Nike Zoom Shoes
    [Tags]    Shoes    Nike_Shoes_Zoom
      [Documentation]   Successfully adding Nike Zoom Shoes into the Cart
        Open Webui  ${browser}  ${url}
        Proceed To Apparel Page
        Proceed To Shoes Page
        Add Shoes    title=Nike SB Zoom Stefan Janoski    count=2
        Proceed To Shopping Cart
        #ISSUE STARTS HERE @SAAKSHI
        Check Item In Cart   Nike SB Zoom Stefan Janoski    count=1
        Sleep    3
            #Check Correct Items Are In Cart
        Close All Browsers
Add Nike Zoom Shoes And Estimate Shipping Without Country Or Zipcode
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    title=Nike SB Zoom Stefan Janoski    count=2
    Proceed To Shopping Cart
    Check Item In Cart   Nike SB Zoom Stefan Janoski



Add Nike Floral Shoes And Continue Shopping
    [Tags]    Nike_Shoes
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=White/Blue     size=9   print=Fresh
    Proceed To Shopping Cart
    Check Item In Cart    Nike Floral Roshe Customized Running Shoes    size=9    print=Fresh
    Click Continue Shopping Button
    Check If Shoes Page
