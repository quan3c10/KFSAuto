*** Setting ***
Resource    Devices.robot
Test Teardown    CommonConfiguration.Test TearDown    
Test Setup    Launch KAC
Variables    ${CURDIR}${/}testdata.py
Default Tags    Devices
*** Test Cases ***
Test Add Device
    [Template]    Device Should Be Added  
    create    True    &{device}     
Test Edit Device
    [Template]    Device Should Be Added  
    edit    &{dvedit}
Test Delete Device
    Device Should Be Remove    &{dvedit}
*** Keyword ***
Device Should Be Added
    [Arguments]    ${mode}    ${cleanup}=False    &{data}    
    BuiltIn.Run Keyword If    '${mode}'=='create'    Devices.Create Device    ${cleanup}    &{data}
    ...    ELSE    Devices.Edit Device    &{data}
    Test TearDown
    Launch KAC
    Device Should Be Update    &{data}    