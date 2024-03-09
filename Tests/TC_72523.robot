*** Settings ***
Library     SeleniumLibrary
Library     Dialogs
Resource    ../Resources/Common.robot


*** Variables ***
${InputName}        Test User
${InputMobileNo}    7021736204

${InputPincode}     400706
${InputAddress}     Random Area, Some Locality, Imaginary Place
${InputFlatNo}      6801


*** Test Cases ***
PopUpTest
    Begin Web Test

    # Visit Get Jio Sim
    Visit Jio.com And Goto    xpath://*[@id="firstlevel-nav"]/ul/li[1]/section/a
    Wait For And Click Element    xpath://*[@id="headerAnimate"]/section[2]/section/nav[1]/ul/li[5]/section/a

    # Enter Name and Number
    Wait For And Input Text    xpath:/html/body/div[1]/div[2]/div[1]/section/div[1]/div[2]/div[1]/input    ${InputName}
    Enter Number and Proceed
    ...    xpath:/html/body/div[1]/div[2]/div[1]/section/div[1]/div[2]/div[2]/input
    ...    ${InputMobileNo}
    ...    xpath://*[@id="__next"]/div[2]/div[1]/section/div[2]/button

    # OTP
    Enter and Verify OTP

    # Select Port/Get Sim and Prepaid/Postpaid options
    Wait For And Click Element    xpath://*[@id="__next"]/div[2]/div/section/section/section/div[1]/div/span[2]
    Wait For And Click Element
    ...    xpath://*[@id="__next"]/div[2]/div/section/section/section/div[2]/div[2]/div/div/div/label/span[2]
    Wait For And Click Element    xpath://*[@id="__next"]/div[2]/div/section/div/div

    # Enter Address
    Wait For And Input Text
    ...    //*[@id="__next"]/div[2]/div/section/section/section/div/div[1]/div/input
    ...    ${InputPincode}
    Wait For And Input Text
    ...    xpath://*[@id="__next"]/div[2]/div/section/section/section/div/div[2]/div/div/div[2]/textarea
    ...    ${InputAddress}
    Exit Address Dropdown
    Enter Number and Proceed
    ...    xpath://*[@id="__next"]/div[2]/div/section/section/section/div/div[3]/input
    ...    ${InputFlatNo}
    ...    xpath://*[@id="__next"]/div[2]/div/section/div/button

    # Select Date and Time
    Wait For And Click Element    xpath://*[@id="__next"]/div[2]/div/section/section/section/div[4]/div/span[2]
    Wait For And Click Element
    ...    xpath://*[@id="__next"]/div[2]/div/section/section/section/section/div[2]/div/div[1]/div[2]/div/div/div/div/section[1]/div/div/label/span[2]
    Wait For And Click Element
    ...    xpath://*[@id="__next"]/div[2]/div/section/section/section/div[5]/button

    # Close Survey PopUp
    Close Popup    xpath:/html/body/section[1]/section/div/div/div/header/button

    # Test View Details PopUps
    FOR    ${index}    IN RANGE    1    3
        ${result}=    Evaluate    ${index} + 1
        Verify View Details
        ...    xpath://*[@id="__next"]/div[2]/section/div[4]/div[${index}]/div/section/div/div[2]/div/div[2]/div/div[4]/div[3]/button[2]
        ...    xpath:/html/body/section[${result}]/section/div/div/div/header/button
    END

    End Web Test


*** Keywords ***
Enter and Verify OTP
    ${InputOTP}=    Get Value From User    message=Enter OTP
    Wait For And Input Text    id:otp-input    ${InputOTP}

Exit Address Dropdown
    Wait For And Click Element    xpath://*[@id="__next"]/div[2]/div/section/section/section/div/div[3]/input

Verify View Details
    [Arguments]    ${locator}    ${cross}
    Scroll To    ${locator}
    Open Popup    ${locator}
    Close Popup    ${cross}
