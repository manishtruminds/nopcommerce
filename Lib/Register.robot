*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/Variables/webelement.yaml

Documentation    This resource file contains keywords for dealing with the registration page


*** Keywords ***

Choose Gender As Male
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${register}[radio_gender]    M
    Radio Button Should Be Set To    ${register}[radio_gender]    M

Choose Gender As Female
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Select Radio Button    ${register}[radio_gender]    F
    Radio Button Should Be Set To    ${register}[radio_gender]    F

Input FirstName
    [Arguments]   ${firstName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text  ${register}[firstname]  ${firstName}

Input LastName
    [Arguments]   ${lastName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text  ${register}[lastname]  ${lastName}


Input Date Of Birth
    [Arguments]    ${day}=0    ${month}=0    ${year}=0
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${register}[birthday_date]    ${day}
    
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${register}[birthday_month]    ${month}
    
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${register}[birthday_year]    ${year}

Input Email
    [Arguments]    ${email}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${register}[email]  ${email}

Input Company
    [Arguments]    ${company}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${register}[company]  ${company}

Select Newsletter Checkbox
    Wait Until Element Is Visible    ${register}[newsletter]    10s
    
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${register}[newsletter]
    IF    ${is_checked} == ${False}
        Select Checkbox    ${register}[newsletter]
    END
    Checkbox Should Be Selected   ${register}[newsletter]

Unselect Newsletter Checkbox
    Wait Until Element Is Visible    ${register}[newsletter]    10s
    
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${register}[newsletter]
    IF    ${is_checked} == ${True}
        Unselect Checkbox    ${register}[newsletter]
    END

    Checkbox Should Not Be Selected   ${register}[newsletter]

Input Password
    [Arguments]    ${password}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${register}[password]    ${password}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${register}[confirm_password]    ${password}

Fill Registration Form
    [Arguments]    ${firstName}    ${lastName}    ${email}    ${password}
    ...            ${day}=0    ${month}=0    ${year}=0
    ...            ${gender}=None    ${company}=None   
    ...            ${want_newsletter}=False    
    
    IF    "${gender}" != "${None}"
        IF    "${gender}" == "M"
            Choose Gender As Male
        ELSE
            Choose Gender As Female
        END       
    END

    Input FirstName    ${firstName}
    Input LastName    ${lastName}
    Input Email    ${email}
    Input Password  ${password}

    Input Date Of Birth    ${day}    ${month}    ${year}

    IF    "${company}" != "${None}"
        Input Company   ${company}        
    END

    IF    ${want_newsletter}
        Select Newsletter Checkbox
    ELSE
        Unselect Newsletter Checkbox
    END


Click Register Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${register}[register_button]

Verify Successful Registration
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain   Your registration completed
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Log out

Verify Unsuccessful Registration
  Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Not Contain   Your registration completed
  Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Not Contain    Log out

Verify Invalid Email Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Wrong email

Verify Invalid Password Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    Password must meet the following rules:

Verify Email Already Exists Message
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Page Should Contain    The specified email already exists
