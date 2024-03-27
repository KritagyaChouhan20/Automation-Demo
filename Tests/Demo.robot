*** Settings ***
Resource    ../Pages/Demo_Page.robot


*** Test Cases ***
Confirm 'view details' pop up opens up on clicking 'View details' button on all the 3 plan tiles
    Test Case - 72523: PopUpTest

Confirm user is redirected to a Installation address page with 'maps' to select an address, if user continues by entering a wrong address in the address field
    Test Case - 92187: RedirectionTest
