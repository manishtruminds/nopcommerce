
*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Variables   ${EXECDIR}/Variables/webelement.yaml
Variables   ${EXECDIR}/Variables/env.yaml

Documentation  This resource file contains WebUI opening related keywords

*** Variables ***
${browser}                                  ${env_variables}[${ENV_TYPE}][browser]
${url}                                      ${env_variables}[${ENV_TYPE}][url]
${username}                                 ${env_variables}[${ENV_TYPE}][username]
${password}                                 ${env_variables}[${ENV_TYPE}][password]

*** Keywords ***
Open Webui
    [Documentation]     Open demo nopcommerce WebUI
    [Arguments]
    LOG  Browser: ${browser}    HTML      console=true
    LOG  URL: ${url}            HTML      console=true
    Wait Until Keyword Succeeds     3 times   5 seconds    Open Webui Repeat    ${browser}       ${url}

Open Webui Repeat
    [Arguments]    ${browser}    ${url}
    #TODO browser specific startup
    Run Keyword If    '${browser}'=='Firefox'  Setup Firefox    ${url}
    ...     ELSE IF   '${browser}'=='Chrome'  Setup Chrome    ${url}
    ...     ELSE IF   '${browser}'=='Edge'  Setup Edge    ${url}

    #Maximize Browser Window
    Log To Console  Setting window size to 1920x1000 for standard execution across displays
    Set Window Size     1920    1000
    ${width}	${height}=  Get Window Size
    log to console   Window: width: ${width} height: ${height}
    Wait Until Element Is Enabled   ${home}[logo_image]    timeout=30

Setup Firefox
    [Arguments]     ${url}
    Log    Setting up Firefox    console=${True}
    ${dc}   Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.FIREFOX  sys, selenium.webdriver
    ${experimental_options}     Create Dictionary      acceptInsecureCerts   ${True}
    Set To Dictionary           ${dc}       chromeOptions   ${experimental_options}
    Open Browser    ${url}    Firefox    desired_capabilities=${dc}
    #Maximize Browser Window


Setup Edge
    [Arguments]     ${url}
    Log    Setting up Edge    console=${True}
    ${dc}   Evaluate    sys.modules['selenium.webdriver'].DesiredCapabilities.EDGE  sys, selenium.webdriver
    ${experimental_options}     Create Dictionary      acceptInsecureCerts   ${True}    acceptSslCerts    ${True}   isJavaScriptEnabled   ${True}   acceptUntrustedCertificates   ${True}
    Set To Dictionary           ${dc}       edgeOptions   ${experimental_options}
    Open Browser    ${url}    Edge    desired_capabilities=${dc}
    #Wait Until Keyword Succeeds    2 times    5 seconds    Click Link    //*[@id="proceed-link"]

    #Click Element
Setup Chrome
    [Arguments]   ${url}
    Log    Setting up Chrome    console=${True}
    Log To Console  Opening browser with popup blocking disabled and ignoring certificate error
    Open Browser    ${url}   Chrome     options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")

Get Test Data
    [Arguments]   ${page}   ${attribute}
    ${data}=  Split String  ${test_data}[${page}][${attribute}]   |
    [return]    ${data}
