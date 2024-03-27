*** Settings ***
Library     SeleniumLibrary
Library     Dialogs
Resource    ../Resources/Common.robot



*** Keywords ***
Go to Apps > Utility
    Visit Jio.com And Goto    xpath:(//*[@id="firstlevel-nav"]//a)[7]

    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//h3
    Scroll To                      xpath://*[@id="__next"]//section[7]//h3

    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//ul/li[1]

JioCloud Test Case - 108068

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

JioCloud Test Case - 108069

    Go to Apps > Utility
    Open Popup  xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[1]
    


