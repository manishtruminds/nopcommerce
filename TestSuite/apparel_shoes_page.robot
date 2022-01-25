
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

Successfully Adding Adidas Shoes Into Cart
    [Tags]    Shoes    Adidas_Shoes
    [Documentation]   Successfully adding Adidas Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    adidas Consortium Campus 80s Running Shoes     size=9
    Sleep    3
    #Check Correct Items Are In Cart
    Close All Browsers

Successfully Adding Nike Floral Shoes Into Cart
    [Tags]    Shoes     Nike_Shoes
    [Documentation]   Successfully adding Nike Floral Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=White/Blue     size=9   print=Natural
    Sleep    3
    #Check Correct Items Are In Cart
    Close All Browsers

Successfully Adding Nike Zoom Shoes Into Cart
    [Tags]    Shoes    Nike_Shoes_Zoom
    [Documentation]   Successfully adding Nike Zoom Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    title=Nike SB Zoom Stefan Janoski    count=2
    Sleep    3
        #Check Correct Items Are In Cart
    Close All Browsers

Successfully Adding Many Shoes Into Cart
    [Tags]    Shoes    Shoes_All
    [Documentation]   Successfully adding Many Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes    adidas Consortium Campus 80s Running Shoes  size=10    square_color=silver
    Go Back
    Add Shoes    Nike Floral Roshe Customized Running Shoes   size=8    list_color=White/Black   print=Fresh
    Go Back
    Add Shoes    Nike SB Zoom Stefan Janoski    count=3
    Close All Browsers
