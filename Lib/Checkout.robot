*** Settings ***
Library    SeleniumLibrary
Variables    ${EXECDIR}/Variables/webelement.yaml

Documentation    This resource file contains keywords for dealing with the checkout page

*** Keywords ***
Add Desktop And Proceed To Checkout As Guest
    Set Selenium Implicit Wait    15s
    Open Webui    ${browser}    ${url}digital-storm-vanquish-3-custom-performance-pc
    Page Should Contain    Digital Storm
    Click Button    //*[@id="add-to-cart-button-2"]
    Sleep    5
    Click Link    //*[@id="topcartlink"]/a
    Page Should Contain    Shopping Cart
    Select Checkbox    //*[@id="termsofservice"]

    Click Button    //*[@id="checkout"]

    Click Button    class:checkout-as-guest-button

Select Same Shipping Address Checkbox
    Wait Until Element Is Visible    ${checkout}[billing_addr][ship_to_same_addr]    10s
    
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]
    IF    ${is_checked} == ${False}
        Select Checkbox    ${checkout}[billing_addr][ship_to_same_addr]
    END
    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]

Unselect Same Shipping Address Checkbox
    Wait Until Element Is Visible    ${checkout}[billing_addr][ship_to_same_addr]    10s
    
    ${is_checked}=    Run Keyword And Return Status    Checkbox Should Be Selected   ${checkout}[billing_addr][ship_to_same_addr]
    IF    ${is_checked} == ${True}
        Unselect Checkbox    ${checkout}[billing_addr][ship_to_same_addr]
    END

    Checkbox Should Not Be Selected   ${checkout}[billing_addr][ship_to_same_addr]
#####
Input Billing Address FirstName
    [Arguments]   ${firstName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[billing_addr][firstname]  ${firstName}

Input Billing Address LastName
    [Arguments]   ${lastName}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[billing_addr][lastname]  ${lastName}

Input Billing Address Email
    [Arguments]    ${email}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Input Text    ${checkout}[billing_addr][email]  ${email}

Input Billing Address Company
    [Arguments]    ${company}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][company]  ${company}

Select Billing Address Country
    [Arguments]    ${country}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[billing_addr][country]    ${country}

Select Billing Address State
    [Arguments]    ${state}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Select From List By Value    ${checkout}[billing_addr][state]    ${state}

Input Billing Address City
    [Arguments]    ${city}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][city]  ${city}

Input Billing Address Addr1
    [Arguments]    ${addr1}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][addr1]  ${addr1}

Input Billing Address Addr2
    [Arguments]    ${addr2}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][addr2]  ${addr2}

Input Billing Address Zip
    [Arguments]    ${zip}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][zip]  ${zip}

Input Billing Address Phone
    [Arguments]    ${phone}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][phone]  ${phone}

Input Billing Address Fax
    [Arguments]    ${fax}
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...                Input Text    ${checkout}[billing_addr][fax]  ${fax}

Click Billing Address Continue Button
    Wait Until Keyword Succeeds    5 times    10 seconds
    ...    Click Button    ${checkout}[billing_addr][continue_button]

Fill Billing Address Form
    [Arguments]    ${firstName}    ${lastName}    ${email}
    ...            ${country}    ${city}    ${addr1}    ${zip}    ${phone}
    ...            ${state}=0    ${company}=None    ${addr2}=None    ${fax}=None

    Input Billing Address FirstName    ${firstName}
    Input Billing Address LastName    ${lastName}
    Input Billing Address Email    ${email}
    
    IF    "${company}" != "${None}"
        Input Billing Address Company   ${company}        
    END
    
    Select Billing Address Country    ${country}
    
    IF    ${state} != 0
        Select Billing Address State    ${state}
    END
    
    Input Billing Address City    ${city}
    Input Billing Address Addr1    ${addr1}
    
    IF    "${addr2}" != "${None}"
        Input Billing Address Addr2    ${addr2}
    END

    Input Billing Address Zip    ${zip}
    Input Billing Address Phone    ${phone}

    IF    "${fax}" != "${None}"
        Input Billing Address Fax    ${fax}
    END
