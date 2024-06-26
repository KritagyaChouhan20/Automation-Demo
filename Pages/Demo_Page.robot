*** Settings ***
Library     SeleniumLibrary
Library     Dialogs
Resource    ../Resources/Common.robot


*** Variables ***
${InputName}        Test User
${InputMobileNo}    7021736204

${InputPincode}     400706
${InputAddress}     NL1
${InputFlatNo}      6801


*** Keywords ***
Test Case - 72523: PopUpTest
    Begin Web Test

    # Visit Get Jio Sim
    Visit Jio.com And Goto                 xpath://*[@id="firstlevel-nav"]/ul/li[1]/section/a
    Wait For And Click Element             xpath://*[@id="headerAnimate"]/section[2]/section/nav[1]/ul/li[5]/section/a

    # Enter Name and Number
    Wait For And Input Text                xpath://*[@class="submitNumber_customInput__31K7u j-container"]/div[1]//input    ${InputName}
    Enter Number and Proceed               xpath://*[@class="submitNumber_customInput__31K7u j-container"]/div[2]//input    ${InputMobileNo}    xpath://*[@class="submitNumber_mobButton__EtdLj"]//button

    # OTP
    Enter and Verify OTP

    # Select Port/Get Sim and Prepaid/Postpaid options
    Wait For And Click Element             xpath://*[@class="j-selectors stretch"]/span[2]
    Wait For And Click Element             xpath:(//*[@class="switch-radio-root"])[1]
    Wait For And Click Element             xpath://*[@class="selectConnection_mobButton__MW7_w"]/div

    # Enter Address
    Wait For And Input Text                xpath://*[@class="pickLocation_pincodeCont__wwINN j-container"]//input    ${InputPincode}
    Wait For And Input Text                xpath://*[@class="pickLocation_addressCont__PUulw j-container"]//textarea    ${InputAddress}
    Wait For And Verify Element            id:addressScrollContent
    Wait For And Click Element             xpath://*[@id="addressScrollContent"]//section[1]
    Enter Number and Proceed               xpath://*[@class="j-field input-text"]//input   ${InputFlatNo}   xpath://*[@class="pickLocation_mobButton__2fPwI"]//button

    # Select Date and Time
    Wait For And Click Element             xpath://*[@class="SlotChooser_dateSelectors__2hjpK j-selectors"]//span[2]
    Wait For And Click Element             xpath://*[@class="customScroll_scroll__1lZUu"]//section[1]//span[2]
    Wait For And Click Element             xpath://*[@class="SlotChooser_mobButton__2zzsv"]//button

    # Close Survey PopUp
    Close Popup                            xpath:(//*[@class="j-modal-container"]//button)[1]

    # Test View Details PopUps
    FOR    ${index}    IN RANGE    1    3
        ${result}=                         Evaluate     ${index} + 1
        Verify View Details                xpath:(//*[@class="Details_flex__3gCbA"])[${index}]//button[2]       xpath:(//*[@class="j-modal j-modal-visible j-modal-closable j-modal-size-s planDetailsPopup j-modal-kind-dialog"]//button)[1]
    END

    End Web Test

Test Case - 92187: RedirectionTest
    Begin Web Test

    # Visit JioFiber
    Visit Jio.com And Goto                 xpath://*[@id="firstlevel-nav"]/ul/li[3]/section/a
    Wait For And Click Element             xpath://*[@id="headerAnimate"]/section[2]/section/nav[3]/ul/li[4]/section/a

    # Enter Name
    Wait For And Input Text                id:enterName    ${InputName}

    #    Enter Valid Pincode
    Wait For And Input Text                id:enterPin    ${InputPincode}

    # Enter Invalid Address
    Wait For And Input Text                id:enterAddress    ${InputAddress}
    Exit Address Dropdown
    Wait For And Input Text                id:enterFlatNo     ${InputName}

    # Enter Valid Mobile Number
    Enter Number and Proceed               id:enterNumber   ${InputMobileNo}        xpath://*[@class="UBRFlow_mobButton__1Dk4O"]//button

    # Test if redirected to the Map Page
    Wait For And Click Element             xpath://*[@class="customAddress_desktopMapStyle__32iBF"]
    End Web Test


Enter and Verify OTP
    ${InputOTP}=                           Get Value From User     message=Enter OTP
    Wait For And Input Text                id:otp-input    ${InputOTP}
 
Exit Address Dropdown
    Wait For And Click Element             xpath://*[@id="__next"]/div[2]/div/section/div/h2/div

Verify View Details
    [Arguments]     ${locator}      ${cross}
    Scroll To       ${locator}
    Open Popup      ${locator}
    Close Popup     ${cross}
