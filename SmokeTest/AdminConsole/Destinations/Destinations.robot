*** Setting ***
Resource    ../AdminFunctions.robot 

*** Variable ***
#General Tab
${txtName}    id:edit-destination-Name
${drType}    id:edit-destination-Type

#Scan Setting tab
${drDPI}    id:edit-scansetting-Dpi
${drColorMode}    id:edit-scansetting-ColorMode
${cbMaximize}    id:edit-scansetting-maximizequalityoverspeed
${cbDeskew}    id:edit-scansetting-deskew
${cbCrop}    id:edit-scansetting-autocrop
${cbRemoval}    id:edit-scansetting-blankpageremoval
${cbRotation}    id:edit-scansetting-autoorient
${cbInherit}    id:edit-scansetting-InheritFromDestination

*** Keyword ***
Create Destination
    [Arguments]    ${cleanup}=False     &{destination}
    Select Button    Destinations
    BuiltIn.Run Keyword If    ${cleanup}    Clean Up 
    Select Button    Create
    AdminFunctions.Set Text Value    Name    ${destination.Name} 
    BuiltIn.Run Keyword If    'general' in &{destination}    Destinations.Fill General    &{destination}[general]
    BuiltIn.Run Keyword If    'profiles' in &{destination}    Destinations.Fill Device Profile    &{destination}[profiles]
    BuiltIn.Run Keyword If    'groups' in &{destination}    Destinations.Fill Group    &{destination}[groups] 
    BuiltIn.Run Keyword If    'scan' in &{destination}    Destinations.Fill ScanSetting    &{destination}[scan]      
    Select Button    Save 
Edit Destination
    [Arguments]    ${destination}
    Select Button    Destinations
    Edit    ${destination.OldName}
    AdminFunctions.Set Text Value    Name    ${destination.Name}    
    BuiltIn.Run Keyword If    'general' in &{destination}    Destinations.Fill General    &{destination}[general]
    BuiltIn.Run Keyword If    'profiles' in &{destination}    Destinations.Fill Device Profile    &{destination}[profiles]
    BuiltIn.Run Keyword If    'groups' in &{destination}    Destinations.Fill Group    &{destination}[groups] 
    BuiltIn.Run Keyword If    'scan' in &{destination}    Destinations.Fill ScanSetting    &{destination}[scan]      
    Select Button    Save 
Destination Should Be Update
    [Arguments]    &{destination}
    Select Button    Destinations
    Edit   ${destination.Name}
    AdminFunctions.Verify Text Value    Name    ${destination.Name} 
    BuiltIn.Run Keyword If    'general' in &{destination}    Destinations.Verify General    &{destination}[general]
    BuiltIn.Run Keyword If    'profiles' in &{destination}    Destinations.Verify Device Profile    &{destination}[profiles]
    BuiltIn.Run Keyword If    'groups' in &{destination}    Destinations.Verify Group    &{destination}[groups] 
    BuiltIn.Run Keyword If    'scan' in &{destination}    Destinations.Verify ScanSetting    &{destination}[scan]   
    Select Button    Cancel 
Destination Should Be Remove
    [Arguments]    &{destination}
    Select Button    Destinations
    AdminFunctions.Delete    ${destination.Name}
    
#Fill value keywords
Fill General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Set Fields Value    ${name}    &{fields}[${name}]    
    
Fill ScanSetting
    [Arguments]    ${fields}
    Select Tab    ScanSettings
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}   
    \    AdminFunctions.Set Fields Value    ${name}    &{fields}[${name}]
Fill Group
    [Arguments]    ${fields}
    Select Tab    Groups   
    Associate    &{fields}[Associated]  
Fill Device Profile
    [Arguments]    ${fields}
    Select Tab    Devices   
    Associate    &{fields}[Associated] 
    
#Verify keywords
Verify General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Verify Fields Value    ${name}    &{fields}[${name}]    
    
Verify ScanSetting
    [Arguments]    ${fields}
    Select Tab    ScanSettings
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}   
    \    AdminFunctions.Verify Fields Value    ${name}    &{fields}[${name}]
Verify Group
    [Arguments]    ${fields}
    Select Tab    Groups  
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False  
Verify Device Profile
    [Arguments]    ${fields}
    Select Tab    Profiles   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False