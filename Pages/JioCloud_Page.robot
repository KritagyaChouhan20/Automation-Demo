*** Settings ***
Library     SeleniumLibrary
Library     Dialogs
Resource    ../Resources/Common.robot



*** Keywords ***
Click "Get Now" Button
    [Arguments]    ${locator}

    Open Popup    ${locator}

    # Wait for Get Now Modal to open
    Wait For And Verify Element    xpath://*[@class="j-modal-container"]


Click "Read more" Button
    Wait For And Click Element    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[2]


Go to Apps > Utility

    Visit Jio.com And Goto         xpath:(//*[@id="firstlevel-nav"]//a)[7]
    # Wait for Apps Page to open
    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//h3
    # Scroll to Utility Section
    Scroll To                      xpath://*[@id="__next"]//section[7]//h3
    # Wait for Cards in Utility section
    Wait For And Verify Element    xpath://*[@id="__next"]//section[7]//ul/li[1]


Go to Apps > Utility > JioCloud
    Go to Apps > Utility

    Click "Read more" Button

    # Verify JioCloud Page Redirection
    Wait For And Verify Element    xpath://*[@id="__next"]//main//a/section


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

    Click "Get Now" Button    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[1]

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

    FOR    ${index}    IN RANGE    1    4
        Click "Get Now" Button    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[1]
        Wait For And Click Element    xpath:(//*[@class="j-modal-container"]//section//button)[${index}]
        Go Back
    END

    Click "Get Now" Button    xpath:(//*[@id="__next"]//section[7]//ul/li[1]//button)[1]
    Close Popup               xpath://*[@class="j-modal-container"]//header//button

    End Web Test


JioCloud Test Case - 108071
    Begin Web Test

    Go to Apps > Utility > JioCloud

    End Web Test

JioCloud Test Case - 108072
    Begin Web Test

    Go to Apps > Utility > JioCloud

    # Verify JioCloud Banner
    Wait For And Verify Element    xpath://*[@id="__next"]//main//section[@role="banner"]

    # Verify JioCloud Logo
    Wait For And Verify Element    xpath://*[@id="__next"]//main//img[@alt="JioCloud logo"]

    # Verify Title
    Wait For And Verify Element    xpath:(//*[@id="__next"]//main//h2)[1]

    # Verify Subtext
    Wait For And Verify Element    xpath://*[@id="__next"]//main//p

    # Verify Get Now Button
    Wait For And Verify Element    xpath://*[@id="__next"]//main//button[@aria-label="Get JioCloud to start using"]

    # Verify Infographics
    FOR    ${index}    IN RANGE    1    5
        # Verify Image
        Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[2]/div[${index}]//img

        # Verify Title
        Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[2]/div[${index}]//h3

        # Verify Subtext
        Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[2]/div[${index}]//div[@class="j-text j-text-body-m"]
    END

    # Verify JioCloud Storage Title
    Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[3]//h2

    FOR    ${index}    IN RANGE    1    5
        # Verify Icon
        Wait For And Verify Element    xpath:(//*[@id="__next"]/div[2]/main//section[3]//div[@class="j-card__content"])[${index}]//span

        # Verify Title
        Wait For And Verify Element    xpath:(//*[@id="__next"]/div[2]/main//section[3]//div[@class="j-card__content"])[${index}]//div[@class="j-heading j-text-body-s-bold"]

        # Verify Subtext
        Wait For And Verify Element    xpath:(//*[@id="__next"]/div[2]/main//section[3]//div[@class="j-card__content"])[${index}]//div[@class="j-text j-text-body-s"]
    END


    # Verify Testimonials

    FOR    ${index}    IN RANGE    1    5
        # Verify User Profile Photo
        Wait For And Verify Element    xpath:(//*[@id="__next"]/div[2]/main//section[4]//div[@data-testid="tesimonial-card"])[${index}]//img

        # Verify User Name
        Wait For And Verify Element    xpath:(//*[@id="__next"]/div[2]/main//section[4]//div[@data-testid="tesimonial-card"])[${index}]//div[@class="j-text j-text-body-s-bold"]

        # Verify User Review
        Wait For And Verify Element    xpath:(//*[@id="__next"]/div[2]/main//section[4]//div[@data-testid="tesimonial-card"])[${index}]//div[@class="j-text j-text-body-m-bold"]
    END

    # Verify FAQ Section
    Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[@aria-label="FAQ"]

    End Web Test


JioCloud Test Case - 108073
    Begin Web Test

    Go to Apps > Utility > JioCloud

    # Verify Get Now Button Redirection
    Click "Get Now" Button    xpath://*[@id="__next"]//main//button[@aria-label="Get JioCloud to start using"]

    End Web Test


JioCloud Test Case - 108074
    Begin Web Test

    Go to Apps > Utility > JioCloud

    # Verify Infographics
    FOR    ${index}    IN RANGE    1    5

        ${result}=    Evaluate    ${index} % 2

        IF    ${result}==1
            ${order}=    Set Variable    style="order: 1;"
        ELSE
            ${order}=    Set Variable    style="order: 2;"

            # Verify Image
            Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[2]/div[${index}]/div[${order}]//img

            # Verify Title
            Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[2]/div[${index}]//h3[@class="j-heading j-text-heading-s"]

            # Verify Subtext
            Wait For And Verify Element    xpath://*[@id="__next"]/div[2]/main//section[2]/div[${index}]//div[@class="j-text j-text-body-m"]
        END
    END

    End Web Test


JioCloud Test Case - 108076
    Begin Web Test

    Go to Apps > Utility > JioCloud

    # Click on JioCloud Banner
    Open Popup    xpath://*[@id="__next"]//main//section[@role="banner"]

    # Verify Modal
    Wait For And Verify Element    xpath://*[@class="j-modal-container"]

    End Web Test
