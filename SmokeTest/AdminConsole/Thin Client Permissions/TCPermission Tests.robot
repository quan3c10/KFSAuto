*** Setting ***
Resource    TCPermissions.robot
Test Teardown    CommonConfiguration.Test TearDown   
Test Setup    Launch KAC
Variables    ${CURDIR}${/}testdata.py
Default Tags    Permissions
*** Test Cases ***
Verify Default Permission
    TC Permission Should Be    &{default}
Test Create Permission
    Create TC Permission     &{permission}   
    TC Permission Should Be    &{vepermission} 
Test Associate And Verify
    Edit TC Permission     &{associate}   
    TC Permission Should Be    &{associate}  
Test Delete Permission
    TC Permission Should Be Remove    &{associate}