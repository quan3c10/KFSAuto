*** Setting ***
Resource    Destinations.robot
Test Teardown    CommonConfiguration.Test TearDown 
Test Setup    Launch KAC
Variables    ${CURDIR}${/}testdata.py
Default Tags    Destination
*** Test Cases ***
Test Create Destination
    Create Destination    &{des}
Test Delete Destination
    Destination Should Be Remove    &{des}