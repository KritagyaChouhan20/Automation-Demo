*** Settings ***
Library     SeleniumLibrary
Library     Dialogs
Resource    ../Resources/Common.robot



*** Keywords ***
Go to Apps > Utility

    Visit Jio.com And Goto         xpath:(//*[@id="firstlevel-nav"]//a)[7]
    # Wait for Apps Page to open
    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//h3
    # Scroll to Utility Section
    Scroll To                      xpath://*[@id="__next"]//section[7]//h3
    # Wait for Cards in Utility section
    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//ul/li[1]


Click "Get Now" Button
    Open Popup                     xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[1]
    # Wait for Get Now Modal to open
    Wait For And Verify Element    xpath://*[@class="j-modal-container"]


JioCloud Test Case - 108068

    Begin Web Test

    Go to Apps > Utility

    # Verify Image
    Wait For And Verify Element    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//img)[1]
    # Verify Logo
    Wait For And Verify Element    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//img)[2]
    # Verify Title
    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//ul/li[1]//h3
    # Verify Subtext
    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//ul/li[1]//*[@class="j-text j-text-body-s"]
    # Verify Get Now
    Wait For And Verify Element    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[1]
    # Verify Read More
    Wait For And Verify Element    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[2]

    End Web Test


JioCloud Test Case - 108069

    Begin Web Test

    Go to Apps > Utility

    Click "Get Now" Button

    # Modal Title
    Wait For And Verify Element    xpath://*[@class="j-modal-container"]//section//h5
    # "Available Only in" text
    Wait For And Verify Element    xpath:(//*[@class="j-modal-container"]//section//*[@class="j-text j-text-body-xs"])[1]
    # Google Play Button
    Wait For And Verify Element    xpath:(//*[@class="j-modal-container"]//section//button)[1]
    # Apple Store Button
    Wait For And Verify Element    xpath:(//*[@class="j-modal-container"]//section//button)[2]
    # "Using a browser" text
    Wait For And Verify Element    xpath:(//*[@class="j-modal-container"]//section//*[@class="j-text j-text-body-xs"])[2]
    # "Go to Website" Button
    Wait For And Verify Element    xpath:(//*[@class="j-modal-container"]//section//button)[3]

    End Web Test


JioCloud Test Case - 108070

    Begin Web Test

    Go to Apps > Utility

    FOR    ${index}    IN RANGE    1    3
        Click "Get Now" Button
        Wait For And Click Element    xpath:(//*[@class="j-modal-container"]//section//button)[${index}]
        Go Back
    END

    Click "Get Now" Button
    Close Popup               xpath://*[@class="j-modal-container"]//header//button

    End Web Test


JioCloud Test Case - 108071
    Begin Web Test

    Go to Apps > Utility
    # Click Read More Button
    Wait For And Click Element     xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[2]
    # Verify JioCloud Page Redirection
    Wait For And Verify Element    xpath://*[@id="__next"]//main//a/section

    End Web Test