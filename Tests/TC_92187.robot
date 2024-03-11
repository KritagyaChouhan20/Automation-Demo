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
RedirectionTest
    Begin Web Test

    # Visit JioFiber
    Visit Jio.com And Goto    xpath://*[@id="firstlevel-nav"]/ul/li[3]/section/a
    Wait For And Click Element    xpath://*[@id="headerAnimate"]/section[2]/section/nav[3]/ul/li[4]/section/a

    # Enter Name
    Wait For And Input Text    id:enterName    ${InputName}

    #    Enter Valid Pincode
    Wait For And Input Text    id:enterPin    ${InputPincode}

    # Enter Invalid Address
    Wait For And Input Text    id:enterAddress    ${InputAddress}
    Exit Address Dropdown
    Wait For And Input Text    id:enterFlatNo    ${InputName}

    # Enter Valid Mobile Number
    Enter Number and Proceed
    ...    id:enterNumber
    ...    ${InputMobileNo}
    ...    xpath://*[@class="UBRFlow_mobButton__1Dk4O"]//button

    # Test if redirected to the Map Page
    Wait For And Click Element
    ...    xpath://*[@class="customAddress_desktopMapStyle__32iBF"]

    End Web Test


*** Keywords ***
Enter and Verify OTP
    ${InputOTP}=    Get Value From User    message=Enter OTP
    Wait For And Input Text    id:otp-input    ${InputOTP}

Exit Address Dropdown
    Wait For And Click Element    xpath://*[@id="__next"]/div[2]/div/section/div/h2/div

Verify View Details
    [Arguments]    ${locator}    ${cross}
    Scroll To    ${locator}
    Open Popup    ${locator}
    Close Popup    ${cross}
