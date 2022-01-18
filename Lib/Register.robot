*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/Variables/webelement.yaml
#Variables   ${EXECDIR}/Variables/env.yaml

Documentation    This resource file contains keywords for dealing with the registration page


*** Keywords ***

Choose Gender
    [Arguments]   ${gender}
    Run Keyword If    "${gender}" != "${EMPTY}"
    ...    Select Radio Button    ${register}[radio_gender]    ${gender}

Input FirstName
    [Arguments]   ${firstName}
    Input Text  ${register}[firstname]  ${firstName}

Input LastName
    [Arguments]   ${lastName}
    Input Text  ${register}[lastname]  ${lastName}


Input DOB
    [Arguments]    ${day}    ${month}    ${year}
    Run Keyword If    "${day}" != "${EMPTY}"
    ...                Select From List By Value    ${register}[birthday_date]    ${day}
    
    Run Keyword If    "${month}" != "${EMPTY}"
    ...                Select From List By Value    ${register}[birthday_month]    ${month}
    
    Run Keyword If    "${year}" != "${EMPTY}"
    ...                Select From List By Value    ${register}[birthday_year]    ${year}

Input Email
    [Arguments]    ${email}
    Input Text    ${register}[email]  ${email}

Input Company
    [Arguments]    ${company}
    Run Keyword If    "${company}" != "${EMPTY}"
    ...                Input Text    ${register}[company]  ${company}

Toggle Newsletter Checkbox
    Unselect Checkbox    ${register}[newsletter]
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${register}[newsletter]
    [Return]    ${is_checked}

Input Password
    [Arguments]    ${password}
    Input Text    ${register}[password]    ${password}
    Input Text    ${register}[confirm_password]    ${password}

Fill Registration Form
    [Arguments]    ${gender}    ${firstName}    ${lastName}
    ...            ${day}    ${month}    ${year}
    ...            ${email}    ${company}    ${password}
    ...            ${want_newsletter}
    
    Choose Gender    ${gender}

    Input FirstName    ${firstName}
    Input LastName    ${lastName}
    Input DOB    ${day}    ${month}    ${year}
    Input Email    ${email}

    Input Company   ${company}

    Input Password  ${password}

    Run Keyword If    not ${want_newsletter}
    ...    Toggle Newsletter Checkbox


Click Register Button
    Click Button    ${register}[register_button]

Verify Successful Registration
    Page Should Contain   Your registration completed
    Page Should Contain    Log out

Verify Unsuccessful Registration
  Page Should Not Contain   Your registration completed
  Page Should Not Contain    Log out
