
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
    Verify Successful Addition
    Sleep    3
    #Check Correct Items Are In Cart
    Close All Browsers

Successfully Adding Nike Floral Shoes Into Cart
    [Tags]    Shoes     Nike_Shoes
    [Documentation]   Successfully adding Nike Floral Shoes into the Cart
    Open Webui  ${browser}  ${url}
    Proceed To Apparel Page
    Proceed To Shoes Page
    Add Shoes   Nike Floral Roshe Customized Running Shoes    list_color=White/Blue     size=9   print=Fresh
    Verify Successful Addition
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
    Verify Successful Addition
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
    Verify Successful Addition
    Go Back
    Add Shoes    Nike Floral Roshe Customized Running Shoes   size=8    list_color=White/Black   print=Fresh
    Verify Successful Addition
    Go Back
    Add Shoes    Nike SB Zoom Stefan Janoski    count=3
    Verify Successful Addition
    Close All Browsers

No Size Error
    [Tags]    Shoes   NoSize
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
    [Tags]    Shoes   NoColor
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
    [Tags]    Shoes   NoPrint
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
    [Tags]    Shoes   ZeroCount
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