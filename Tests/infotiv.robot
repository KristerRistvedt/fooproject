*** Settings ***

Documentation       This is a test suite around login and car booking on a predetermined Infotiv web page
Library             SeleniumLibrary
Test Setup          Begin Infotiv Page Test
Test Teardown       End Infotiv Page Test

*** Variables ***

${BROWSER} =                    firefox
${URL} =                        http://rental13.infotiv.net/
${SEARCH_TERM} =                Infotiv Car Rental
${LOGIN} =                      xpath://*[@id="login"]
${USERNAME} =                   xpath://*[@id="email"]
${PASSWORD} =                   xpath://*[@id="password"]
${CHOOSE_CAR} =                 xpath://*[@id="bookModelSpass5"]

*** Keywords ***

Begin Infotiv Page Test
        Open Browser                about:blank     ${BROWSER}

Go to Web Page
        Go To                       ${URL}
        Wait Until Page Contains    Infotiv Car Rental

Choose Date
        Click Button                    xpath://*[@id="continue"]
        Wait Until Element Is Visible   xpath://*[@id="bookModelSpass5"]

Login to Page
        Input Text                      ${USERNAME}     Krister.Ristvedt@iths.se
        Input Text                      ${PASSWORD}     Infotivtest
        Click Button                    ${LOGIN}
        Wait Until Page Contains        Logout

Select Car
        Click Button                    ${CHOOSE_CAR}
        Wait Until Page Contains         Confirm booking of Tesla Model S

Confirm Booking
        Input Text                      xpath://*[@id="cardNum"]        1234567891011121
        Input Text                      xpath://*[@id="fullName"]       Krister Ristvedt
        Select From List By Label       xpath://html/body/div/div[2]/div[2]/form/select[1]      12
        Select From List By Label       xpath://html/body/div/div[2]/div[2]/form/select[2]      2023
        Input Text                      xpath://*[@id="cvc"]            141
        Click Button                    xpath://*[@id="confirm"]
        Wait Until Page Contains        Home

Cancel Booking
        Click Button                    xpath://*[@id="mypage"]
        Click Button                    xpath://*[@id="unBook1"]
        Alert Should Be Present
        Wait Until Page Contains        has been Returned

Bad Booking
        Input Text                      xpath://*[@id="cardNum"]        abcdefghijklmnop
        Input Text                      xpath://*[@id="fullName"]       l33t sp33k
        Select From List By Label       xpath://html/body/div/div[2]/div[2]/form/select[1]      12
        Select From List By Label       xpath://html/body/div/div[2]/div[2]/form/select[2]      2023
        Input Text                      xpath://*[@id="cvc"]            vcv
        Click Button                    xpath://*[@id="confirm"]


User Logs Out
        Click Button                    xpath://*[@id="logout"]
        Wait Until Page Contains        Login

End Infotiv Page Test
        Close Browser

that the user is logged in, booked a car and is on My Page
        Go to Web Page
        Login to Page
        Choose Date
        Select Car
        Confirm Booking
        Click Button                    xpath://*[@id="mypage"]

the user clicks Cancel booking
        Click Button                    xpath://*[@id="unBook1"]

the booking should be canceled
        Alert Should Be Present
        Wait Until Page Contains        has been Returned

that the user is logged in, has chosen a rental date and car
    Go to Web Page
    Login to Page
    Choose Date
    Select Car

the user enters bad information on credentials page and clicks confirm
    Bad Booking

the booking should fail
    Page Should Not Contain         Home

the user clicks on the cancel button on the Confirm Booking page
    Click Button                    xpath://*[@id="cancel"]

the booking should abort
    Page Should Not Contain         Confirm booking of

*** Test Cases ***

User can access Infotiv Car Rental
    [Documentation]             Test: The user should be able to access the Infotiv Car Rental page
    [Tags]                      access      Header
    Go to Web Page

User can login to Infotiv Car Rental Page
    [Documentation]             Test: The user should be able to login to the Infotiv Car Rental page
    [Tags]                      login       Header
    Go to Web Page
    Login to Page

User can book a car
    [Documentation]             Test: The user should be able to book a car
    [Tags]                      DateSelection     CarSelection        ConfirmBooking      SuccessfulBooking      book      Header
    Go to Web Page
    Login to Page
    Choose Date
    Select Car
    Confirm Booking
    Cancel Booking

User books a car with letters
    [Documentation]             Test: The user should not be able to book a car using the wrong indata
    [Tags]                      BadBooking        DateSelection     CarSelection        ConfirmBooking      Header
    Given that the user is logged in, has chosen a rental date and car
    When the user enters bad information on credentials page and clicks confirm
    Then the booking should fail

User can cancel booking
    [Documentation]             Test: The user should be able to cancel a booking of a car
    [Tags]                      VG-test     DateSelection     CarSelection        ConfirmBooking     MyPage     unbook      cancel      Header
    Given that the user is logged in, booked a car and is on My Page
    When the user clicks Cancel booking
    Then the booking should be canceled

User can abort a booking
    [Documentation]             Test: The user should be able to abort a booking of a car
    [Tags]                      AbortBooking    DateSelection   CarSelection
    Given that the user is logged in, has chosen a rental date and car
    When the user clicks on the cancel button on the Confirm Booking page
    Then the booking should abort

User can log out
    [Documentation]             Test: The user should be able to log out from the Infotiv Car Rental page
    [Tags]                      logout      Header
    Go to Web Page
    Login to Page
    User Logs Out