*** Setting ***
Resource         Shortcuts.robot
Resource         ../Device Profiles/Profiles.robot
Resource         ../Destinations/Destinations.robot
Test Teardown    CommonConfiguration.Test TearDown
Test Setup       Launch KAC
Variables        ${CURDIR}${/}testdata.py
Suite Setup    Test Setup
Suite Teardown    Clean Data
Default Tags    Shortcuts
*** Test Cases ***
Test Create Shortcut
    Create Shortcut    cleanup=True    &{sc}
    Shortcut Should Be Update    &{scverify}
Test Edit Shortcut
    Edit Shortcut    &{scedit}   
    Shortcut Should Be Update    &{scedit} 
Test Delete Shortcut
    Shortcut Should Be Remove    &{scedit}
*** Keywords ***
Test Setup
    Launch KAC
    Profiles.Create Device Profile     cleanup=True    &{profile1}
    Profiles.Create Device Profile     &{profile2}
    Profiles.Create Device Profile     &{profile3}
    Destinations.Create Destination    &{des}
    Test TearDown
Clean Data
    Launch KAC
    Select Button    Profiles
    Clean Up
    Select Button    Destinations
    Destination Should Be Remove    &{des}
    Test TearDown
    
    