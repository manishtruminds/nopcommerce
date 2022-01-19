***Settings***
Library                                                                         SeleniumLibrary
Resource                                                                        ${EXECDIR}/Lib/Common_Utils.robot
***Variables***
***Keywords***
Proceed To Login Page
    [Documentation]   Moving to Login Page
    Click Link  ${home}[login]
    Wait Until Keyword Succeeds    3 times  10 seconds    Title Should Be    nopCommerce demo store. Login
