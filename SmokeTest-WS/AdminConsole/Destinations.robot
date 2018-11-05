*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
Resource    Profiles.robot
*** Keyword ***
Add Destination
    [Arguments]    ${destination}
    ${export}=    Get Default Export Settings  
    ${scan}=    Get Default Scan Settings
    ${destype}=    Get Destination Type    &{destination}[Destination Type]
    ${fields}=    Get Destination Fields    ${destype} 
    Run Keyword If    'Fields' in ${destination}    Set Fields Values    ${fields}    &{destination}[Fields]           
    ${body}=    Create Destination Body    ${export}    ${scan}    ${destype}    ${fields}    ${destination}
    &{res}=    Post    ${KACPage}DestinationService/destination//    body=${body}
    Check Response    ${res}
Associate Group
    [Arguments]    ${destination}
    ${objdes}=    Get Destination    ${destination.Name} 
    :FOR    ${group}    IN    @{destination.Groups['Associated']} 
    \    ${associated}=    Run Keyword And Return Status    Is Associated    Name    ${group}    &{objdes}[AssociatedGroups]    
    \    ${available}=    Run Keyword If    not ${associated}    Is Available    Name    ${group}    &{objdes}[AvailableGroups]
    \    Run Keyword If    ${available}    Append To List    &{objdes}[AssociatedGroups]    ${available}       
    &{res}=    Put    ${KACPage}DestinationService/destination//    body=${objdes} 
    Check Response    ${res}    
Associate Profile
    [Arguments]    ${destination}
    ${objdes}=    Get Destination    ${destination.Name} 
    :FOR    ${profile}    IN    @{destination.Profiles['Associated']} 
    \    ${associated}=    Run Keyword And Return Status    Is Associated    Name    ${profile}    &{objdes}[AssociatedProfiles]    
    \    ${available}=    Run Keyword If    not ${associated}    Is Available    Name    ${profile}    &{objdes}[AvailableProfiles]
    \    Run Keyword If    ${available}   Append To List    &{objdes}[AssociatedProfiles]    ${available}       
    &{res}=    Put    ${KACPage}DestinationService/destination//    body=${objdes} 
    Check Response    ${res}             
Create Destination Body
    [Arguments]    ${export}    ${scan}    ${destype}    ${fields}    ${destination}
    ${empty}=    Create List    
    ${adminobject}=    Create Dictionary    AdminExportSetting=${export}    AdminScanSetting=${scan}    AuthPassword=${destination.AuthPassword}
    ...    AuthUser=${destination.AuthUser}    Description=${destination.Description}    DestinationType=${destype}
    ...    Fields=${fields}    Name=${destination.Name}    IsVisibleOnThinClient=true    IsVisibleOnMFP=true    IsVisibleOnMobile=true
    ${body}=    Create Dictionary    AdminObject=${adminobject}    ExportSettings=${export}    ScanSettings=${scan}    Fields=${fields}
    ...    AssociatedGroups=${empty}    AssociatedProfiles=${empty} 
    [Return]    ${body}         
Get Destination Type
    [Arguments]    ${name}
    &{res}=    Get    ${KACPage}DestinationService/destinationtypes//
    Check Response    ${res} 
    ${types}=    Convert To List    ${res.body['AdminObjects']} 
    :FOR    ${type}    IN    @{types}        
    \    ${return}=    Run Keyword If    '${type.Name}'=='${name}'    Convert To Dictionary    ${type}
    \    Exit For Loop If    ${return}!=None
    [Return]    ${return}           
Get Default Scan Settings
    &{res}=    Get    ${KACPage}ScanSettingsService/scanSetting/default//
    Check Response    ${res} 
    [Return]    ${res.body['AdminObject']} 
Get Default Export Settings
    &{res}=    Get    ${KACPage}ExportSettingsService/exportSetting/default//
    Check Response    ${res} 
    [Return]    ${res.body['AdminObject']}
Get Destination Fields
    [Arguments]    ${type}
    ${type}=    Create Dictionary    DestinationType=${type}
    &{res}=    Post    ${KACPage}DestinationService/destinationtypes//    body=${type}        
    Check Response    ${res} 
    [Return]    ${res.body['Fields']}
Get All Destination
    [Arguments]    ${name}
    &{res}=    Get    ${KACPage}DestinationService/destinations//
    Check Response    ${res} 
    ${destinations}=    Convert To List    ${res.body['AdminObjects']} 
    :FOR    ${destination}    IN    @{destinations}        
    \    ${return}=    Run Keyword If    '${destination.Name}'=='${name}'    Convert To Dictionary    ${destination}
    \    Exit For Loop If    ${return}!=None
    [Return]    ${return}  
Get Destination ID
    [Arguments]    ${name}
    &{destination}=    Get All Destination    ${name}  
    Run Keyword If    '${destination}'=='None'    Fail    The destination with name "${name}" does not exists.
    [Return]    ${destination.ID}
Get Destination
    [Arguments]    ${name}
    ${id}=    Get Destination ID    ${name}
    &{res}=    Get    ${KACPage}DestinationService/destination/${id}
    Check Response    ${res}
    [Return]    &{res}[body]        
Verify General
    [Arguments]    ${destination}
    ${actual}=    Get Destination    ${destination.Name}  
    Should Be Equal As Strings    ${actual.AdminObject['Name']}    ${destination.Name} 
    Should Be Equal As Strings    ${actual.AdminObject['Description']}    ${destination.Description}
    ${destype}=    Get Destination Type    &{destination}[Destination Type]
    Dictionaries Should Be Equal    ${actual.AdminObject['DestinationType']}    ${destype}
    Verify Fields    &{actual}[Fields]    &{destination}[Fields] 
Verify Associated Groups
    [Arguments]    ${destination}
    ${actual}=    Get Destination    ${destination.Name}
    :FOR    ${group}    IN    @{destination.Groups['Associated']}
    \    Is Associated    Name    ${group}    &{actual}[AssociatedGroups]
    :FOR    ${group}    IN    @{destination.Groups['Available']}
    \    Is Available    Name    ${group}    &{actual}[AvailableGroups]  
Verify Associated Profiles
    [Arguments]    ${destination}
    ${actual}=    Get Destination    ${destination.Name}
    :FOR    ${profile}    IN    @{destination.Profiles['Associated']}
    \    Is Associated    Name    ${profile}    &{actual}[AssociatedProfiles]
    :FOR    ${profile}    IN    @{destination.Profiles['Available']}
    \    Is Available    Name    ${profile}    &{actual}[AvailableProfiles]   
                              