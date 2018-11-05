*** Setting ***
Resource    UsersAndGroups.robot
Resource    ../Thin Client Permissions/TCPermissions.robot
Resource    ../Shortcuts/Shortcuts.robot
Test Teardown    CommonConfiguration.Test TearDown   
Test Setup    Launch KAC
Variables    ${CURDIR}${/}testdata.py
Default Tags    Users And Groups
Suite Setup    Test Setup
Suite Teardown    Clean Data
*** Test Cases ***
Test Associate And Verify Users
    Edit Users    &{KCAuto01}
    Users Should Be    &{KCAuto01}
Test Disassociate And Verify Users
    Edit Users    &{editKCAuto01}
    Users Should Be    &{editKCAuto01} 
Test Associate And Verify Groups
    Edit Groups     &{GroupTest1}   
    Groups Should Be    &{GroupTest1}  
Test Disassociate And Verify Groups
    Edit Groups     &{editGroup1}   
    Groups Should Be    &{editGroup1}  
*** Keywords ***
Test Setup
    Launch KAC
    Create TC Permission    &{permission}
    Create Shortcut    cleanup=True     &{shortcut}
    Test TearDown
Clean Data
    Launch KAC
    Select Button    Permissions
    TC Permission Should Be Remove    &{permission}
    Select Button    Shortcuts
    Clean Up
    Test TearDown