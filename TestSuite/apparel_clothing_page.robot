
*** Settings ***
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
Resource                                                                        ${EXECDIR}/Lib/Login.robot
Resource                                                                        ${EXECDIR}/Lib/Register.robot
Resource                                                                        ${EXECDIR}/Lib/Home.robot
Resource                                                                        ${EXECDIR}/Lib/Apparel.robot
Resource                                                                        ${EXECDIR}/Lib/Clothing.robot
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
${browser}                                  ${env_variables}[${ENV_TYPE}][browser]
${url}                                      ${env_variables}[${ENV_TYPE}][url]
${username}                                 ${env_variables}[${ENV_TYPE}][username]
${password}                                 ${env_variables}[${ENV_TYPE}][password]


*** Test Cases ***

Successfully Adding Clothes into cart
    [Tags]    Clothes
    [Documentation]   Successfully adding clothes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=1X
    Go Back
    Add Clothes    Custom T-Shirt   custom_text=My New Shirt  count=2
    Sleep    3
    #Check Correct Items Are In Cart
    Close All Browsers

Empty Custom TextBox
    [Tags]    Clothes   Unsuccessful_Addition   EmptyCustomTextbox
    [Documentation]   Unsuccessful in adding clothes into the Cart due to empty custom textbox error
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Custom T-Shirt
    Sleep    3

    Close All Browsers

Empty Size TextBox
    [Tags]    Clothes   Unsuccessful_Addition   EmptySizetextbox
    [Documentation]   Unsuccessful in adding clothes into the Cart due to empty size textbox error
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt
    Sleep    3
    Close All Browsers

Negative Count Error
    [Tags]    Clothes   Unsuccessful_Addition   NegativeCountError
    [Documentation]   Unsuccessful in adding clothes into the Cart due to negative or zero count of items
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Clothing Page
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   count=0   size=Small
    Go Back
    Add Clothes    Custom T-Shirt   custom_text=Hie  count=-1
    Sleep    3
    Close All Browsers

Successfully Adding Adidas Shoes Into Cart
    [Tags]    Shoes
    [Documentation]   Successfully adding Adidas Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add I
    Add Clothes    Nike Tailwind Loose Short-Sleeve Running Shirt   size=1X
    Go Back
    Add Clothes    Custom T-Shirt   custom_text=My New Shirt  count=2
    Sleep    3
    #Check Correct Items Are In Cart
    Close All Browsers
