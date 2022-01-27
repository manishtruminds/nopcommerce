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
    Check Item In Cart    Custom T-Shirt
    Select Term And Conditions
    Click Checkout Button    Yes
    Close All Browsers

Add Adidas Shoes Into Cart And Choose Giftwrap Option
    [Documentation]   Adding adidas shoes to cart and choosing gift wrap Option
    [Tags]    Shoes  Adidas_Shoes
    Open Webui    ${browser}    ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=9
    Proceed To Shopping Cart
    Check Item In Cart    adidas
    Choose Giftwrap Option    Yes
    #Verify Gift Wrap Option   Yes
    Select Term And Conditions
    Click Checkout Button    No
    Close All Browsers
