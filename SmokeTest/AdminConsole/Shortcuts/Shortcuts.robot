*** Setting ***
Resource    ../AdminFunctions.robot

*** Variable ***
#General Tab
${txtName}    id:edit-shortcut-Name
${drDestination}    id:edit-shortcut-Destination
${txtBatchPriority}    id:edit-shortcut-field-Internal-Priority
${drFormType}    id:edit-shortcut-field-Internal-Form-Type

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
Create Shortcut
    [Arguments]    ${cleanup}=False    &{shortcut}
    Select Button    Shortcuts
    BuiltIn.Run Keyword If    ${cleanup}    Clean Up  
    Select Button    Create
    AdminFunctions.Set Text Value    Name    ${shortcut.Name} 
    AdminFunctions.Select Dropdown Value    Destination    ${shortcut.destination}
    Run Keyword If    'formtype' in &{shortcut}    AdminFunctions.Select Dropdown Value    Form Type    ${shortcut.formtype}
    BuiltIn.Run Keyword If    'general' in &{shortcut}    Shortcuts.Fill General    &{shortcut}[general]
    BuiltIn.Run Keyword If    'profiles' in &{shortcut}    Shortcuts.Fill Device Profile    &{shortcut}[profiles]
    BuiltIn.Run Keyword If    'groups' in &{shortcut}    Shortcuts.Fill Group    &{shortcut}[groups] 
    BuiltIn.Run Keyword If    'scan' in &{shortcut}    Shortcuts.Fill ScanSetting    &{shortcut}[scan]      
    Select Button    Save 
Edit Shortcut
    [Arguments]    &{shortcut}
    Select Button    Shortcuts
    Edit    ${shortcut.OldName}
    AdminFunctions.Set Text Value    Name    ${shortcut.Name} 
    BuiltIn.Run Keyword If    'general' in &{shortcut}    Shortcuts.Fill General    &{shortcut}[general]
    BuiltIn.Run Keyword If    'profiles' in &{shortcut}    Shortcuts.Fill Device Profile    &{shortcut}[profiles]
    BuiltIn.Run Keyword If    'groups' in &{shortcut}    Shortcuts.Fill Group    &{shortcut}[groups] 
    BuiltIn.Run Keyword If    'scan' in &{shortcut}    Shortcuts.Fill ScanSetting    &{shortcut}[scan]      
    Select Button    Save 
Shortcut Should Be Update
    [Arguments]    &{shortcut}
    Select Button    Shortcuts
    Edit    ${shortcut.Name}
    AdminFunctions.Verify Text Value    Name    ${shortcut.Name} 
    BuiltIn.Run Keyword If    'general' in &{shortcut}    Shortcuts.Verify General    &{shortcut}[general]
    BuiltIn.Run Keyword If    'profiles' in &{shortcut}    Shortcuts.Verify Device Profile    &{shortcut}[profiles]
    BuiltIn.Run Keyword If    'groups' in &{shortcut}    Shortcuts.Verify Group    &{shortcut}[groups] 
    BuiltIn.Run Keyword If    'scan' in &{shortcut}    Shortcuts.Verify ScanSetting    &{shortcut}[scan]   
    Select Button    Cancel 
Shortcut Should Be Remove
    [Arguments]    &{shortcut}
    Select Button    Shortcuts
    AdminFunctions.Delete    ${shortcut.Name}
    
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
    Select Tab    Devices   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False  