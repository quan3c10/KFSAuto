*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
Resource    Profiles.robot
*** Keyword ***  
Add Device
    [Arguments]    ${device}    ${profile}=
    ${reprofile}=    Run Keyword If    '${profile}'!=''    Get Profile    ${profile}
    ...    ELSE    Create Dictionary    PrimaryKey=    NaturalKey=
    Set To Dictionary    ${device}    ProfileReference=${reprofile}                 
    ${body}=    Create Dictionary    AdminObject=${device}
    &{res}=    Post    ${KACPage}DeviceService/device//    body=${body}
    Check Response    ${res}
Verify Device
    [Arguments]    ${device}
    &{actual}=    Get Device    ${device.DeviceName}
    Dictionary Should Contain Sub Dictionary    ${actual}    ${device}    msg=Expect ${device} but actual ${actual}      

Get Device
    [Arguments]    ${name}
    ${id}=    Get Device ID    ${name}    
    Run Keyword If    '${id}'=='None'    Fail    Devive with Name "${name}" doesn't exists      
    &{res}=    Get    ${KACPage}DeviceService/device/${id}  
    Check Response    ${res}  
    ${return}=    Set Variable     ${res.body['AdminObject']}   
    [Return]    ${return}  
Get Device ID
    [Arguments]    ${name}
    &{res}=    Get    ${KACPage}DeviceService/devices//   
    Check Response    ${res}
    @{devices}=    Convert To List    ${res.body['AdminObjects']}
    :FOR    ${device}    IN    @{devices}        
    \    ${return}=    Set Variable If    '${device.DeviceName}'=='${name}'    ${device.ID}
    \    Exit For Loop If    '${return}'!='None'
    [Return]    ${return}   
Get Profile Reference
    [Arguments]    ${name}
    &{pro}=    Get Profile    ${name}   
    ${return}=    Create Dictionary    PrimaryKey=${pro.ID}    NaturalKey=${pro.Name}    
    [Return]    ${return}    

                    