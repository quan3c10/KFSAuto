*** Setting ***
Resource    ../TestResource/CommonFunctions.robot 
*** Keyword ***
Add Profile
    [Arguments]    ${profile}              
    ${body}=    Create Dictionary    AdminObject=${profile}
    &{res}=    Post    ${KACPage}ProfileService/profile//    body=${body}
    Check Response    ${res}
Verify Profile
    [Arguments]    ${profile}    ${device}    
    Verify General    ${profile}   
    Verify Associate    ${profile}    ${device}
Associate Device
    [Arguments]    ${profile}    ${device}
    ${pro}=    Get Profile    ${profile.Name} 
    ${associated}=    Run Keyword And Return Status    Is Associated    DeviceName    ${device}    &{pro}[AssociatedDevices]
    Run Keyword If    not ${associated}    Associate    ${pro}    ${device}
Associate
    [Arguments]    ${profile}    ${device}
    ${device}=    Is Available    DeviceName    ${device}    &{profile}[AvailableDevices]
    Append To List    &{profile}[AssociatedDevices]    ${device}
    ${body}=    Create Dictionary    AdminObject=&{profile}[AdminObject]    AssociatedDevices=&{profile}[AssociatedDevices]        
    &{res}=    Put    ${KACPage}ProfileService/profile//    body=${body}   
    Check Response    ${res}               
          
Get All Profile
    [Arguments]    ${name}
    &{res}=    Get    ${KACPage}ProfileService/profiles//
    Check Response    ${res} 
    ${profiles}=    Convert To List    ${res.body['AdminObjects']} 
    :FOR    ${profile}    IN    @{profiles}        
    \    ${return}=    Run Keyword If    '${profile.Name}'=='${name}'    Convert To Dictionary    ${profile}
    \    Exit For Loop If    ${return}!=None
    [Return]    ${return} 
Get Profile ID
    [Arguments]    ${name}
    &{profile}=    Get All Profile    ${name}  
    Run Keyword If    '${profile}'=='None'    Fail    The profile with name "${name}" does not exists.
    [Return]    ${profile.ID}
Get Profile
    [Arguments]    ${name}
    ${id}=    Get Profile ID    ${name}
    &{res}=    Get    ${KACPage}ProfileService/profile/${id}
    Check Response    ${res}
    [Return]    &{res}[body]         
Verify General
    [Arguments]    ${profile}
    &{actual}=    Get All Profile    ${profile.Name}  
    Dictionary Should Contain Sub Dictionary    ${actual}    ${profile}      
Verify Associate
    [Arguments]    ${profile}    ${device}
    ${pro}=    Get Profile    ${profile.Name}
    ${result}=    Run Keyword And Return Status    Is Associated    DeviceName    ${device}    &{pro}[AssociatedDevices]    
    Run Keyword If    not ${result}    Fail    Device "${device}" is not associated with profile "${profile.Name}"                         