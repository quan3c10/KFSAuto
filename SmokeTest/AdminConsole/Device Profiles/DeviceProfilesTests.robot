*** Setting ***
Resource    Profiles.robot
Resource    ../Shortcuts/Shortcuts.robot
Resource    ../Devices/Devices.robot
Test Teardown    CommonConfiguration.Test TearDown   
Test Setup    Launch KAC
Variables    ${CURDIR}${/}testdata.py
Suite Setup    Test Setup
Suite Teardown    Clean Data
Default Tags    Device Profiles
*** Test Cases ***
Test Create Device Profile
    Create Device Profile    cleanup=True    &{profile}
    Device Profile Should Be Update    &{profile}
Test Associate Device
    Edit Device Profile     &{assdevice}   
    Device Profile Should Be Update    &{assdevice} 
Test Associate Shortcut
    Edit Device Profile     &{asshortcut}   
    Device Profile Should Be Update    &{asshortcut} 
Test Edit Device Profile
    Edit Device Profile    &{editprofile}   
    Device Profile Should Be Update    &{editprofile} 
Test Delete Device Profile
    Device Profile Should Be Remove    &{editprofile}
*** Keywords ***
Test Setup
    Launch KAC
    Create Device    True    &{device1}
    Create Device    &{device2}
    Create Shortcut    True    &{sc1}
    Create Shortcut    &{sc2}    
    Test TearDown
Clean Data
    Launch KAC
    Select Button    Shortcuts
    Clean Up
    Select Button    Devices
    Clean Up
    Test TearDown