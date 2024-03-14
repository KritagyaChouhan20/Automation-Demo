*** Settings ***
Library         SeleniumLibrary
Library         ExcelLibrary
Library         RequestsLibrary
Library         String
Library         Collections
Variables       Common_Variables.yaml
Library         PyLibr.py
Library         DateTime


*** Variables ***
${Tester_Name}      Tester06


*** Keywords ***
# --------------------------------------------------Browser Setup And Teardown---------------------
Log Suite Start Time
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log    Test suite started at: ${timestamp}

Begin Web Test
    Open Excel Document    filename=Resources/JioWeb.xlsx    doc_id=JioWeb
    Open Browser    about:blank    ${Browser}
    Maximize Browser Window
    Log Suite Start Time

Begin Devices Web Test
    Log    ${Browser}-${Tester_Name}
    Close All Excel Documents
    Open Excel Document    filename=Resources/JioWeb.xlsx    doc_id=JioWeb
    Open Browser    about:blank    ${Browser}
    Maximize Browser Window
    Log Suite Start Time
    Visit Jio.com And Goto    xpath=//a[@href="/jcms/devices/discover/"]
    Set Screenshot Directory    ./Results/Devices/Devices/Devices_Screenshots/

Begin Choice Number Web Test
    Open Excel Document    filename=Resources/JioWeb.xlsx    doc_id=JioWeb
    Open Browser    about:blank    ${Browser}
    Maximize Browser Window
    Log Suite Start Time
    Visit Jio.com And Goto
    ...    xpath=//a[@class='j-link group__link']//div[@class='j-text j-text-body-m'][normalize-space()='Choice number']
    Set Screenshot Directory    ./Results/ChoiceNumber/ChoiceNumbber/ChoiceNumber_Screenshots/

Verify Page Loaded
    [Arguments]    ${timeout}
    Wait For Condition    return document.readyState == "complete"    ${timeout}

Log Suite End Time
    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log    Test suite ended at: ${timestamp}

End Web Test
    Close All Excel Documents
    Log Suite End Time
    Close Browser
# --------------------------------------------------Browser Setup And TearDown End--------------------

# ----------------------------------------------------Action----------------------------------------

Visit Jio.com
    Go To    ${URL}
    Sleep    500ms

Visit Jio.com And Goto
    [Arguments]    ${Page}
    Visit Jio.com
    Wait For And Click Element    ${Page}
    # Wait Until Keyword Succeeds    1 min    0 sec    CSS Verification    ${Page}    text-decoration-line    underline

Scroll To
    [Arguments]    ${locator}
    Sleep    200ms
    TRY
        Scroll Element Into View    ${locator}
    EXCEPT
        ${h}=    Get Horizontal Position    ${locator}
        ${v}=    Get Vertical Position    ${locator}
        Execute Javascript    window.scrollTo(${h},${v});
    END
    Wait Until Element Is Visible    ${locator}

Take Page Screenshot
    [Arguments]    ${Sc_Name}
    Sleep    200ms
    Run Keyword And Continue On Failure
    ...    Wait Until Keyword Succeeds
    ...    2mins
    ...    10s
    ...    Capture Page Screenshot
    ...    ${Sc_Name}.png

Take Element Screenshot
    [Arguments]    ${locator}    ${SC_name}
    Sleep    200ms
    Capture Element Screenshot    ${locator}    ${SC_name}.png

Change Tab
    [Arguments]    ${title}
    Sleep    100ms
    Switch Window    title=${title}
    Sleep    100ms

Reloading Page
    Reload Page
    Sleep    200ms

Wait For And Click Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    TRY
        Click Element    ${locator}
    EXCEPT
        ${ele}=    Get WebElement    ${locator}
        Execute Javascript    arguments[0].click();    ARGUMENTS    ${ele}
    END

Open Popup
    [Arguments]    ${locator}
    Wait For And Click Element    ${locator}

Enter Number and Proceed
    [Arguments]    ${Txt_locator}    ${Number}    ${Contine_Button}
    Wait For And Input Text    ${Txt_locator}    ${Number}
    Wait For And Click Element    ${Contine_Button}
    Sleep    200ms

Wait For And Input Text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Sleep    100ms
    Input Text    ${locator}    ${text}

Take Element Text
    [Arguments]    ${Elocator}
    Wait Until Element Is Visible    ${Elocator}    timeout=5s
    ${temp}=    Get Text    ${Elocator}
    RETURN    ${temp}

Close Popup
    [Arguments]    ${cross}
    Wait For And Click Element    ${cross}
# -----------------------------------------------------Action End-------------------------------------

# --------------------------------------------------Verification-------------------------------------

Section Verification
    [Arguments]    ${locator}    ${name}
    Scroll To    ${locator}
    Wait For And Verify Element    ${locator}
    Log To Console    ${name} Section is Visible

Banner Content Verification
    [Arguments]    ${Txt_locator}    ${txt}    ${Img_locator}    ${Btn_locator}    ${Scn_Name}
    Wait For And Verify Content    ${Txt_locator}    ${txt}
    Wait For And Verify Element    ${Img_locator}
    Wait For And Verify Element    ${Img_locator}
    ${Buttons}=    Get WebElements    ${Btn_locator}
    FOR    ${Button}    IN    @{Buttons}
        Mouse Over    ${Button}
        Page Should Contain Button    ${Button}
    END
    Take Page Screenshot    ${Scn_Name}
    Log To Console    ${Scn_Name} Section Content Verified

Redirection On Clicking
    [Arguments]    ${Button}    ${WebPageURL}    ${Sc_name}
    Scroll To    ${Button}
    ${main_url}=    Get Location
    Wait For And Click Element    ${Button}
    Sleep    2s
    Verify Page Loaded    10s
    Log To Console    ${WebPageURL}
    URL Validation    ${WebPageURL}
    Take Page Screenshot    ${Sc_name}
    Go Back
    # If Go Back function doesn't work
    ${go_back_url}=    Get Location
    ${status}=    Run Keyword And Return Status    Should Not Be Equal    ${main_url}    ${go_back_url}
    IF    ${status}    Go To    ${main_url}
    Sleep    1s
    Log To Console    ${Sc_name} Redirection Successful

Banner Redirection
    [Arguments]    ${locator}    ${Sc_Name}    ${Module}= None
    ${visiblity}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//ul[@class='slick-dots']
    ${RURL}=    Get Location

    IF    ("${Module}" == 'Mobile')
        ${1st-digit}=    Set Variable    1
    ELSE IF    ("${Module}" == 'Fiber')
        ${1st-digit}=    Set Variable    0
    END

    IF    ${visiblity} == True
        ${VB}=    Set Variable    0
        ${VB1}=    Set Variable    1
        WHILE    ${VB} < 3
            Wait For And Click Element    xpath=(//ul[@class='slick-dots']//li)[${VB1}]

            # ! Script to be added here for Test case 69818 re-direction of banner buttons

            Sleep    1s
            Take Page Screenshot    ${Sc_Name}_BannerRedirection_${VB}
            Log To Console    ${Sc_Name}_Banner_${VB} Redirection Successful
            Go To    ${RURL}
            ${VB}=    Evaluate    ${VB} + 1
            ${VB1}=    Evaluate    ${VB1} + 1
        END
    ELSE
        Wait For And Click Element    ${locator}
        Take Page Screenshot    ${Sc_Name}_BannerRedirection
        Log To Console    ${Sc_Name}_Banner_Redirection Successful
        Go Back
    END

# ---------------------------------------------------Validation----------------------------------------

Wait For And Verify Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5s
    Wait Until Page Contains Element    ${locator}

Image Verification
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Page Should Contain Image    ${locator}
    ${img src}=    Get element attribute    ${locator}    src
    Create Session    img    ${img src}
    ${resp_google}=    GET On Session    img    ${img src}    expected_status=200

CSS Verification
    [Arguments]    ${locator}    ${attribute name}    ${attribute_value}
    ${css}=    Get WebElement    ${locator}
    ${prop_val}=    Call Method    ${css}    value_of_css_property    ${attribute name}
    Should Be Equal As Strings    ${prop_val}    ${attribute_value}

Element Attribute Verification
    [Arguments]    ${locator}    ${attribute name}    ${attribute_value}
    Wait Until Element Is Visible    ${locator}
    Run Keyword And Continue On Failure
    ...    Element Attribute Value Should Be
    ...    ${locator}
    ...    ${attribute name}
    ...    ${attribute_value}

# --------------------------------------------------Verification End-----------------------------------

# --------------------------------------------------Validation-----------------------------------------

Wait For And Verify Content
    [Arguments]    ${locator}    ${str}
    Wait Until Element Is Visible    ${locator}
    Sleep    300ms
    Run Keyword And Continue On Failure    Element Should Contain    ${locator}    ${str}

URL Validation
    [Arguments]    ${VURL}
    Sleep    200ms
    ${current_url}=    Get Location
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${current_url}    ${VURL}    strip_spaces=true

Text Verification
    [Arguments]    ${locator}    ${title}
    Wait Until Element Is Visible    ${locator}
    ${text}=    Get Text    ${locator}
    Should Be Equal As Strings    ${text}    ${title}    strip_spaces=true

# --------------------------------------------------Validation End--------------------------------------

# ---------------------------------------------------Functionality-----------------------------------------
# ------- Used In Mobile,Fiber(Recharge Popup Verification, FAQ Section Verification),Apps(Check Window Count & Validation)

Plan Page UI Verification
    [Arguments]    ${title}
    Text Verification
    ...    xpath=//section[@id="headingCategory"]//div[@class="Filter_category__2vFb8 j-text j-text-heading-xs"]
    ...    ${title}
    # # Check if it is In Flight packs plan page
    # IF    "${title}" == "In-Flight Packs"
    #    LOG    ${title}
    # ELSE
    #    Wait For And Verify Element    xpath=//section[contains(@class,"desktop")]//button//*[contains(normalize-space(),"Other")]
    # END

    # Get the number of plan cards
    ${elements}=    Get WebElements    xpath=//div[@class="planDetailsCard_container__2wAgj"]
    ${length}=    Get Length    ${elements}
    Take Page Screenshot    ${title}
    FOR    ${i}    IN RANGE    1    ${length}+1
        Scroll To    xpath=(//div[@class="planDetailsCard_container__2wAgj"])[${i}]
        # Verify sub category name
        Wait For And Verify Element    xpath=(//div[@class="planDetailsCard_container__2wAgj"])[${i}]
    END
    Wait For And Verify Element    xpath=//div[@class="MoreInformation_moreInfo__2qAx3 j-text j-text-heading-s"]
    ${elements}=    Get WebElements
    ...    xpath=//div[@class="MoreInformation_buttonCont__1bLIb"]//button[contains(@class,'secondary')]
    FOR    ${element}    IN    @{elements}
        Wait For And Verify Element    ${element}
    END

Check Filter Button
    Open Popup    xpath=//section[contains(@class,'desktop')]//div[contains(@class, 'filterBtn')]//Button[2]
    # UI verification
    Text Verification    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//h4    Filter
    ${checkboxes}=    Get WebElements
    ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"]
    FOR    ${checkbox}    IN    @{checkboxes}
        Wait For And Verify Element    ${checkbox}
        Checkbox Should Not Be Selected    ${checkbox}
    END
    Wait For And Verify Element
    ...    xpath=//*[contains(@class,"visible")]//button//*[contains(normalize-space(),"Show plans")]
    Wait For And Verify Element
    ...    xpath=//*[contains(@class,"visible")]//button//*[contains(normalize-space(),"Clear filter")]
    Wait For And Verify Element
    ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//header[@class='j-modal-header']//button
    # Filter pop-up Functionality
    ${length}=    Get Length    ${checkboxes}
    FOR    ${i}    IN RANGE    1    ${length}+1
        Wait For And Click Element
        ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]//span[2]
        Checkbox Should Be Selected
        ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]//input
        ${Plan_Name}=    Take Element Text
        ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]
        Wait For And Click Element
        ...    xpath=//*[contains(@class,"visible")]//button//*[contains(normalize-space(),"Show plans")]
        Sleep    1s
        Run Keyword And Continue On Failure
        ...    Text Verification
        ...    xpath=//section[contains(@class,'desktop')]//div[@class="Subcategory_heading__3Y18a j-text j-text-heading-m"]
        ...    ${Plan_Name}
        Wait For And Click Element
        ...    xpath=(//section[contains(@class,'desktop')]//div[@class='Filter_filter__2yX0Z']//button[@class="j-tag active clickable"])[1]
        Sleep    1s
        Open Popup    xpath=//section[contains(@class,'desktop')]//div[contains(@class, 'filterBtn')]//Button[2]
    END
    @{Plan_List}=    Create List
    # All planfilter & Clear button
    FOR    ${i}    IN RANGE    1    ${length}+1
        Wait For And Click Element
        ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]//span[2]
        Checkbox Should Be Selected
        ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]//input
        ${Plan_Name}=    Take Element Text
        ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]
        Append To List    ${Plan_List}    ${Plan_Name}
    END
    Log    ${Plan_List}
    Wait For And Click Element
    ...    xpath=//*[contains(@class,"visible")]//button//*[contains(normalize-space(),"Show plans")]
    ${elements}=    Get WebElements
    ...    xpath=//section[contains(@class,'desktop')]//div[@class="Subcategory_heading__3Y18a j-text j-text-heading-m"]
    ${Plan_count}=    Get Length    ${elements}
    FOR    ${i}    IN RANGE    0    ${Plan_count}
        Text Verification    ${elements}[${i}]    ${Plan_List}[${i}]
    END
    Open Popup    xpath=//section[contains(@class,'desktop')]//div[contains(@class, 'filterBtn')]//Button[2]
    Wait For And Click Element
    ...    xpath=//*[contains(@class,"visible")]//button//*[contains(normalize-space(),"Clear filter")]
    FOR    ${checkbox}    IN    @{checkboxes}
        Wait For And Verify Element    ${checkbox}
        Checkbox Should Not Be Selected    ${checkbox}
    END
    Close Popup
    ...    xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//header[@class='j-modal-header']//button

Plan Card Verification
    [Arguments]
    ...    ${Sheet_name}
    ...    ${Amt_locator}
    ...    ${VDBT_locator}
    ...    ${Recharge_Button}
    ...    ${View_Button}
    ...    ${title}
    # To Decide Start and End of Loop
    ${j}=    Decide Start and End    1    1000    ${title} Plans Start    ${Sheet_name}
    ${Start}=    Set Variable    ${j+2}
    ${End}=    Decide Start and End    1    1000    ${title} Plans End    ${Sheet_name}

    # For Loop for validating plan card details
    Wait Until Keyword Succeeds    0 min    30 sec    Wait For And Verify Element    ${Amt_locator}
    FOR    ${i}    IN RANGE    ${Start}    ${End}
        ${Amt}=    Take Element Text    ${Amt_locator}
        ${Amt}=    Replace String    ${Amt}    \n    ${EMPTY}
        ${E_Amt}=    Read Excel Cell    row_num=${i}    col_num=1    sheet_name=${Sheet_name}
        ${E_Amt}=    Replace String    ${E_Amt}    \n    ${EMPTY}
        IF    "${Amt}" == "${E_Amt}"
            ${VDBT}=    Take Element Text    ${VDBT_locator}
            ${E_VDBT}=    Read Excel Cell    row_num=${i}    col_num=2    sheet_name=${Sheet_name}
            IF    '''${VDBT}''' == '''${E_VDBT}'''
                Should Be Equal    ${VDBT}    ${E_VDBT}
            ELSE
                Log    Details not matched.
            END
        END
    END
    Wait For And Verify Element    ${Recharge_Button}
    Wait For And Verify Element    ${View_Button}

View Details Popup Verification
    [Arguments]
    ...    ${Sheet_name}
    ...    ${View_Button}
    ...    ${Amt_locator}
    ...    ${Details_locator}
    ...    ${OTT_Subs}
    ...    ${Cross}
    ...    ${title}
    Scroll To    ${View_Button}
    Wait Until Keyword Succeeds    30sec    1sec    Open Popup    ${View_Button}
    # For Loop for validating plan card details
    ${j}=    Decide Start and End    1    1000    ${title} Plans Start    ${Sheet_name}
    ${Start}=    Set Variable    ${j+2}
    ${End}=    Decide Start and End    1    1000    ${title} Plans End    ${Sheet_name}
    # For Loop for validating View Details Popup details
    FOR    ${i}    IN RANGE    ${Start}    ${End}
        Wait Until Keyword Succeeds    30sec    1sec    Wait For And Verify Element    ${Amt_locator}
        ${Amt}=    Take Element Text    ${Amt_locator}
        # Uncomment IF part to write the data in excel
        # Write Excel Cell    row_num=${i}    col_num=1    value=${Amt}    sheet_name=${Sheet_name}
        # Save Excel Document    filename=Resources/JioWeb.xlsx
        ${Amt}=    Replace String    ${Amt}    \n    ${EMPTY}
        ${E_Amt}=    Read Excel Cell    row_num=${i}    col_num=1    sheet_name=${Sheet_name}
        # ${E_Amt}=    Replace String    ${E_Amt}    \n    ${EMPTY}
        ${status}=    Run Keyword And Return Status
        ...    Should Be Equal As Strings
        ...    ${Amt}
        ...    ${E_Amt}
        ...    strip_spaces=True
        IF    ${status}
            Wait Until Keyword Succeeds    1min    1sec    Wait For And Verify Element    ${Details_locator}
            ${Details}=    Take Element Text    ${Details_locator}
            ${E_Details}=    Read Excel Cell    row_num=${i}    col_num=3    sheet_name=${Sheet_name}
            Should Be Equal    ${Details}    ${E_Details}
            ${presense}=    Run Keyword And Return Status    Element Should Be Visible    ${OTT_Subs}
            IF    ${presense} == True
                ${elements}=    Get WebElements    ${OTT_Subs}
                FOR    ${element}    IN    @{elements}
                    Wait For And Verify Element    ${element}
                END
            ELSE
                Log    OTT Subscription Not Present
            END
            Sleep    100ms
            ${Hyperlink_presence}=    Run Keyword And Return Status
            ...    Element Should Be Visible
            ...    ${Details_locator}//a
            IF    ${Hyperlink_presence} == True
                ${V-URL}=    Get Element Attribute    ${Details_locator}//a    href
                ${Link_Name}=    Take Element Text    ${Details_locator}//a
                Wait For And Click Element    ${Details_locator}//a
                Sleep    200ms
                Check Window count and Validation    ${Link_Name}    ${V-URL}
            END
            IF    "${Amt}" == "${E_Amt}"    BREAK
        END
    END
    Wait Until Keyword Succeeds    30sec    1sec    Close Popup    ${Cross}

Recharge Popup Verification
    [Arguments]
    ...    ${Recharge_locator}
    ...    ${Amt_locator}
    ...    ${View_Button}
    ...    ${RURL}
    ...    ${Number}
    # Only Pass Prepaid Number
    Scroll To    ${Amt_locator}
    ${Amt}=    Take Element Text    ${Amt_locator}
    ${Amt}=    Replace String    ${Amt}    \n    ${EMPTY}
    ${Amt}=    Replace String    ${Amt}    +GST    ${EMPTY}
    ${Popup_Presense}=    Run Keyword And Return Status
    ...    Element Should Be Visible
    ...    xpath=//div[contains(@class,'j-modal-visible j-modal-closable')]
    IF    ${Popup_Presense} == True
        Open Popup    ${Recharge_locator}
        Recharge UI Verification
        Sleep    200ms
        Recharge Functionality Verification
        Sleep    300ms
        Wait Until Keyword Succeeds    2 min    5 sec    Scroll To    ${View_Button}
        Wait Until Keyword Succeeds    2 min    5 sec    Open Popup    ${View_Button}
        Open Popup    ${Recharge_locator}
        Sleep    1s    # Due to network issue
        Enter Number and Proceed
        ...    //div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//input[@type='tel']
        ...    ${Number}
        ...    //div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//button[@aria-label="button Continue"]

        Wait Until Keyword Succeeds    1mins    30s    Wait For And Verify Element    (//div[@class="css-13ado4o"])
        # //div[normalize-space()='Payment']
        Take Page Screenshot    View_${Amt}_Payment_Page
        Go To    ${RURL}
    ELSE
        Open Popup    ${Recharge_locator}
        Recharge UI Verification
        Recharge Functionality Verification
        Open Popup    ${Recharge_locator}
        Sleep    1s    # Due to network issue
        Enter Number and Proceed
        ...    //div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//input[@type='tel']
        ...    ${Number}
        ...    //div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//button[@aria-label="button Continue"]
        Sleep    3s
        Wait Until Keyword Succeeds
        ...    1mins
        ...    30s
        ...    Wait For And Verify Element
        ...    xpath=(//div[normalize-space()='Payment'][1]) | (//div[@class="css-13ado4o"])
        # //div[normalize-space()='Payment'] | (//div[@class="css-1s8dl3g"])[1]
        Take Page Screenshot    ${Amt}_Payment_Page
        Go To    ${RURL}
    END

Recharge UI Verification
    # Rupee Logo
    Wait For And Verify Element    xpath=(//div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//span)[1]
    # Recharge Heading
    Text Verification
    ...    xpath=(//div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//div[@class='j-text j-text-heading-xs'])
    ...    Recharge
    # Mobile No TextField
    Wait For And Verify Element
    ...    xpath=//div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//input[@type='tel']
    # Cross Icon
    Wait For And Verify Element    xpath=(//div[contains(@class,'j-modal-visible j-modal-closable')]//button)[1]
    # ----------------Popup Functionality Verification-------------------------------------------#
    Element Should Be Disabled
    ...    xpath=//div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//button[@aria-label="button Continue"]

Recharge Functionality Verification
    # --------------------------Invalid Number Validation-------------------------------#
    Wait For And Input Text
    ...    xpath=//div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//input[@type='tel']
    ...    ${Incorrect_No1}
    Element Should Be Enabled
    ...    xpath=//div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//button[@aria-label="button Continue"]
    Wait For And Click Element
    ...    xpath=//div[contains(@class,'j-modal j-modal-visible j-modal-closable')]//button[@aria-label="button Continue"]
    # Invalid Number Error
    Wait Until Keyword Succeeds
    ...    1 min
    ...    30 sec
    ...    Text Verification
    ...    xpath=//div[@class='txt-align--left j-text j-text-body-s']
    ...    It seems you have entered a non-Jio number. Please try again with a Jio number
    Close Popup    xpath=(//div[contains(@class,'j-modal-visible j-modal-closable')]//button)[1]

FAQ Section Validation
    [Arguments]    ${FAQ_URL}    ${SC_name}
    # Checking if there are multiple tabs or not
    ${visiblity}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    xpath=(//section[contains(@class,'desktop')]//div[@class='j-tabs-list j-tabs-list--overflow-scroll'])
    IF    ${visiblity} == True
        Log to console    Tabs are    present
        Log    Tabs are present
        # if multiple    tabs are visible taking there length for loop
        ${Tabs}=    Get WebElements    xpath=(//div[@class='j-tabs-list j-tabs-list--overflow-scroll'])[1]//button
        ${count}=    Get Length    ${Tabs}
        # For Loop for multiple tabs
        ${a}=    Set Variable    0
        FOR    ${i}    IN RANGE    0    ${count}
            Wait For And Click Element    xpath=//button[@aria-controls="panel-${i}"]//div
            Sleep    200ms
            ${questions}=    Get WebElements
            ...    xpath=(//div[@id='panel-${i}'])[1]//div[@class='j-listBlock__block-root']
            ${Length of questions}=    Get Length    ${questions}
            FOR    ${j}    IN RANGE    1    ${Length of questions+1}
                Sleep    100ms
                Wait For And Verify Element
                ...    xpath=((//div[@id='panel-${i}'])[1]//div[@class='j-listBlock__suffix'])[${j}]//span[contains(@class,'j-accordion-panel-icn')]
                Wait For And Click Element
                ...    ((//div[@id='panel-${i}'])[1]//div[@class='j-listBlock__block-root'])[${j}]
                Sleep    100ms
                Wait For And Verify Element
                ...    xpath=((//div[@id='panel-${i}'])[1]//div[@class='j-listBlock__suffix'])[${j}]//span[contains(@class,'j-accordion-panel-icn active')]
                Scroll To    xpath=//div[@aria-hidden='false']
                Sleep    50ms
                Run Keyword And Continue On Failure
                ...    CSS Verification
                ...    xpath=//div[@aria-hidden='false']//div[@class="Faq_accContent__7yDk6"]
                ...    text-align
                ...    left
                ${presense}=    Run Keyword And Return Status
                ...    Wait Until Element Is Visible
                ...    //div[@aria-hidden='false']//a
                IF    ${presense} == True
                    ${elements}=    Get WebElements    xpath=//div[@aria-hidden='false']//a
                    ${Length of hyperlink}=    Get Length    ${elements}
                    FOR    ${k}    IN RANGE    1    ${Length of hyperlink+1}
                        Sleep    200ms
                        Scroll To    xpath=(//div[@aria-hidden='false']//a)[${k}]
                        Wait For And Click Element    xpath=(//div[@aria-hidden='false']//a)[${k}]
                        Check Window count and Validation    ${SC_name}_${k}    ${FAQ_URL}[${a}]
                        ${a}=    Evaluate    ${a} + 1
                    END
                END
            END
            Sleep    300ms
            IF    ${i} == 3    BREAK
        END
    ELSE
        Log to console    Tabs are not present
        Log    Tabs are not present
        # Creating list of WebElement locators of FAQ questions
        ${ques}=    Get WebElements    xpath=//section[contains(@class,'faq')]//div[@class='j-accordion-panel']
        # Calculating its length
        ${length_of_ques}=    Get Length    ${ques}
        # Scrolling to FAQ section
#    Scroll To    xpath=(//*[normalize-space()='FAQ'])[1]
        Scroll To    xpath=//section[contains(@class,'faq')]//div[@class='j-accordion-panel'][5]
        ${a}=    Set Variable    0
        # For loop for clicking each question
        FOR    ${i}    IN RANGE    1    ${length_of_ques+1}
            Sleep    200ms
            # Checking    accordian sign before clicking question
            Wait For And Verify Element
            ...    xpath=(//section[contains(@class,'faq')]//div[@class='j-accordion-panel']//span[contains(@class,'j-accordion-panel-icn')])[${i}]
            # Clicking to expand question
            Wait For And Click Element
            ...    xpath=//section[contains(@class,'faq')]//div[@class='j-accordion-panel'][${i}]//i
            # Checking    accordian sign after clicking question
            Wait For And Verify Element    xpath=//span[contains(@class,'j-accordion-panel-icn active')]

            # Checking presense of hyperlink
            ${presense}=    Run Keyword And Return Status
            ...    Wait Until Element is visible
            ...    xpath=//div[@class='j-accordion-panel__inner' and @aria-hidden='false']//a
            IF    ${presense} == True
                ${hyperlinks}=    Get WebElements
                ...    xpath=//div[@class='j-accordion-panel__inner' and @aria-hidden='false']//a
                ${Length of hyperlink}=    Get Length    ${hyperlinks}
                FOR    ${k}    IN RANGE    1    ${Length of hyperlink+1}
                    Sleep    200ms
                    Scroll To    xpath=(//div[@aria-hidden='false']//a)[${k}]
                    Wait For And Click Element    xpath=(//div[@aria-hidden='false']//a)[${k}]
                    Check Window count and Validation    ${SC_name}_${k}    ${FAQ_URL}[${a}]
                    ${a}=    Evaluate    ${a} + 1
                END
                Sleep    1s
                Wait For And Click Element
                ...    xpath=//section[contains(@class,'faq')]//div[@class='j-accordion-panel active']//i
            ELSE
                Scroll To    xpath=//section[contains(@class,'faq')]//div[@class='j-accordion-panel'][4]
                Wait For And Click Element
                ...    xpath=//section[contains(@class,'faq')]//div[@class='j-accordion-panel active']//i
            END
        END
    END

More Information Section Redirection
    [Arguments]    ${Button_locator}    ${Vurl}    ${title}
    ${elements}=    Get WebElements    ${Button_locator}
    ${j}=    Set Variable    0
    FOR    ${element}    IN    @{elements}
        ${Bname}=    Take Element Text    ${element}
        Sleep    500ms
        Wait For And Click Element    ${element}
        Sleep    50ms
        ${Status}=    Run Keyword And Return Status    Should Be String    ${Vurl}
        Log To Console    ${Status}
        ${URL-Len}=    Get List Length    ${Vurl}
        ${windowhandles}=    Get Window Handles
        ${len}=    Get Length    ${windowhandles}
        IF    ${Status} == False and ${len} > 1
            Check Window count and Validation    ${title}_${Bname}    ${Vurl}[${j}]
            ${j}=    Evaluate    ${j} + 1
        ELSE
            Check Window count and Validation    ${title}_${Bname}    ${Vurl}
        END
    END

Check Window count and Validation
    [Arguments]    ${Sc_Name}    ${FAQ-URL}=False
    # Below sleep is important
    Sleep    1s
    ${windowhandles}=    Get Window Handles
    ${len}=    Get Length    ${windowhandles}
    IF    ${len} >= 2
        Switch Window    NEW
        Sleep    500ms
        # !Hyperlink URL validation error will be ignored, can be removed if not required
        Run Keyword And Continue On Failure
        ...    URL Validation
        ...    ${FAQ-URL}
        Take Page Screenshot    ${Sc_Name}
        Sleep    100ms
        Close Window
        Switch Window    MAIN
        IF    ${len} == 3
            Switch Window    NEW
            Sleep    100ms
            Close Window
            Switch Window    MAIN
        END
    ELSE
        ${Popup_Presense}=    Run Keyword And Return Status
        ...    Element Should Be Visible
        ...    xpath=//div[contains(@class,'j-modal-visible j-modal-closable')]
        IF    ${Popup_Presense} == True
            ${String_Presense}=    Run Keyword And Return Status    Should Contain    ${Sc_Name}    Store Offer
            Take Page Screenshot    ${Sc_Name}
            IF    ${String_Presense} == True
                Close Popup    xpath=//div[contains(@class,'j-modal-visible j-modal-closable')]//span
            ELSE
                Close Popup    xpath=//div[contains(@class,'j-modal-visible j-modal-closable')]//button
            END
        ELSE
            Sleep    300ms
            Run Keyword And Continue On Failure    URL Validation    ${FAQ-URL}
            Take Page Screenshot    ${Sc_Name}
            Go Back
        END
    END

Decide Start and End
    [Arguments]    ${start}    ${end}    ${Find-String}    ${Sheet_name}
    FOR    ${row}    IN RANGE    ${start}    ${end}
        ${Page_Title}=    Read Excel Cell    row_num=${row}    col_num=1    sheet_name=${Sheet_name}
        ${status}=    Run Keyword And Return Status
        ...    Should Be Equal As Strings
        ...    ${page_title}
        ...    ${find-string}
        ...    strip_spaces=true
        IF    ${status}    BREAK
    END
    RETURN    ${row}
# -------------------------------------------------Functionality End----------------------------------------
