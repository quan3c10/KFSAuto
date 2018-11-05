*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
Resource    Profiles.robot
Resource    Destinations.robot
*** Keyword ***
Add Shortcut
    [Arguments]    ${shortcut}
    ${destination}=    Get Destination    ${shortcut.Destination}  
    ${fields}=    Get Shortcut Fields    ${destination.AdminObject['ID']}
    Run Keyword If    'Fields' in ${shortcut}    Set Fields Values    ${fields}    &{shortcut}[Fields]                
    ${body}=    Create Shortcut Body    ${fields}    ${destination}    ${shortcut}
    &{res}=    Post    ${KACPage}ShortcutService/shortcut//    body=${body}
    Check Response    ${res}
Associate Group
    [Arguments]    ${shortcut}
    ${objsc}=    Get Shortcut    ${shortcut.Name} 
    :FOR    ${group}    IN    @{shortcut.Groups['Associated']} 
    \    ${associated}=    Run Keyword And Return Status    Is Associated    Name    ${group}    &{objsc}[AssociatedGroups]    
    \    ${available}=    Run Keyword If    not ${associated}    Is Available    Name    ${group}    &{objsc}[AvailableGroups]
    \    Run Keyword If    ${available}    Append To List    &{objsc}[AssociatedGroups]    ${available}       
    &{res}=    Put    ${KACPage}ShortcutService/shortcut//    body=${objsc} 
    Check Response    ${res}    
Associate Profile
    [Arguments]    ${shortcut}
    ${objsc}=    Get Shortcut    ${shortcut.Name} 
    :FOR    ${profile}    IN    @{shortcut.Profiles['Associated']} 
    \    ${associated}=    Run Keyword And Return Status    Is Associated    Name    ${profile}    &{objsc}[AssociatedProfiles]    
    \    ${available}=    Run Keyword If    not ${associated}    Is Available    Name    ${profile}    &{objsc}[AvailableProfiles]
    \    Run Keyword If    ${available}   Append To List    &{objsc}[AssociatedProfiles]    ${available}       
    &{res}=    Put    ${KACPage}ShortcutService/shortcut//    body=${objsc} 
    Check Response    ${res}             
Create Shortcut Body
    [Arguments]    ${fields}    ${destination}    ${shortcut}
    ${empty}=    Create List 
    ${desref}=    Create Dictionary    NaturalKey=${destination.AdminObject['Name']}    PrimaryKey=${destination.AdminObject['ID']}   
    ${adminobject}=    Create Dictionary    AdminExportSetting=&{destination}[ExportSettings]    AdminScanSetting=&{destination}[ScanSettings]
    ...    Description=${shortcut.Description}    DestinationReference=${desref}    Fields=${fields}    Name=${shortcut.Name}    
    ...    FormType=${shortcut.Name}
    ${body}=    Create Dictionary    AdminObject=${adminobject}    ExportSettings=&{destination}[ExportSettings]    ScanSettings=&{destination}[ScanSettings]    
    ...    Fields=${fields}    AssociatedGroups=${empty}    AssociatedProfiles=${empty} 
    [Return]    ${body}   
Get Shortcut Fields
    [Arguments]    ${desid}
    ${desid}=    Create Dictionary    DestinationID=${desid}
    &{res}=    Post    ${KACPage}ShortcutService/shortcut/fields//    body=${desid}        
    Check Response    ${res} 
    [Return]    ${res.body['Fields']}
Get All Shortcut
    [Arguments]    ${name}
    &{res}=    Get    ${KACPage}ShortcutService/shortcuts//
    Check Response    ${res} 
    ${shortcuts}=    Convert To List    ${res.body['AdminObjects']} 
    :FOR    ${shortcut}    IN    @{shortcuts}        
    \    ${return}=    Run Keyword If    '${shortcut.Name}'=='${name}'    Convert To Dictionary    ${shortcut}
    \    Exit For Loop If    ${return}!=None
    [Return]    ${return}  
Get Shortcut ID
    [Arguments]    ${name}
    &{shortcut}=    Get All shortcut    ${name}  
    Run Keyword If    '${shortcut}'=='None'    Fail    The shortcut with name "${name}" does not exists.
    [Return]    ${shortcut.ID}
Get Shortcut
    [Arguments]    ${name}
    ${id}=    Get Shortcut ID    ${name}
    &{res}=    Get    ${KACPage}ShortcutService/shortcut/${id}
    Check Response    ${res}
    [Return]    &{res}[body]        
Verify General
    [Arguments]    ${shortcut}
    ${actual}=    Get Shortcut    ${shortcut.Name}  
    Should Be Equal As Strings    ${actual.AdminObject['Name']}    ${shortcut.Name} 
    Should Be Equal As Strings    ${actual.AdminObject['Description']}    ${shortcut.Description}
    ${destination}=    Get From Dictionary    ${actual.AdminObject['DestinationReference']}    NaturalKey
    Should Be Equal As Strings    ${destination}    ${shortcut.Destination}     
    Verify Fields    &{actual}[Fields]    &{shortcut}[Fields] 
Verify Associated Groups
    [Arguments]    ${shortcut}
    ${actual}=    Get Shortcut    ${shortcut.Name}
    :FOR    ${group}    IN    @{shortcut.Groups['Associated']}
    \    Is Associated    Name    ${group}    &{actual}[AssociatedGroups]
    :FOR    ${group}    IN    @{shortcut.Groups['Available']}
    \    Is Available    Name    ${group}    &{actual}[AvailableGroups]  
Verify Associated Profiles
    [Arguments]    ${shortcut}
    ${actual}=    Get Shortcut    ${shortcut.Name}
    :FOR    ${profile}    IN    @{shortcut.Profiles['Associated']}
    \    Is Associated    Name    ${profile}    &{actual}[AssociatedProfiles]
    :FOR    ${profile}    IN    @{shortcut.Profiles['Available']}
    \    Is Available    Name    ${profile}    &{actual}[AvailableProfiles]   
                              