*** Setting ***
Resource    ../AdminFunctions.robot

*** Variable ***
#General Tab
${txtName}    id:edit-profile-Name
${txtDes}    id:edit-profile-Description
${cbLogin}    id:edit-profile-Login
${cbDefault}    id:edit-profile-Default

*** Keyword ***
Create Device Profile
    [Arguments]    ${cleanup}=False    &{profile}
    Select Button    Profiles
    BuiltIn.Run Keyword If    ${cleanup}    Clean Up  
    Select Button    Create
    AdminFunctions.Set Text Value    Name    ${profile.Name} 
    BuiltIn.Run Keyword If    'general' in &{profile}    Profiles.Fill General    &{profile}[general]
    BuiltIn.Run Keyword If    'shortcuts' in &{profile}    Profiles.Fill Shortcuts    &{profile}[shortcuts]
    BuiltIn.Run Keyword If    'destinations' in &{profile}    Profiles.Fill Destinations    &{profile}[destinations] 
    BuiltIn.Run Keyword If    'devices' in &{profile}    Profiles.Fill Devices    &{profile}[devices]      
    Select Button    Save 
Edit Device Profile
    [Arguments]    &{profile}
    Select Button    Profiles
    Edit    ${profile.OldName}
    AdminFunctions.Set Text Value    Name    ${profile.Name} 
    BuiltIn.Run Keyword If    'general' in &{profile}    Profiles.Fill General    &{profile}[general]
    BuiltIn.Run Keyword If    'shortcuts' in &{profile}    Profiles.Fill Shortcuts    &{profile}[shortcuts]
    BuiltIn.Run Keyword If    'destinations' in &{profile}    Profiles.Fill Destinations    &{profile}[destinations] 
    BuiltIn.Run Keyword If    'devices' in &{profile}    Profiles.Fill Devices    &{profile}[devices]      
    Select Button    Save 
Device Profile Should Be Update
    [Arguments]    &{profile}
    Select Button    Profiles
    Edit    ${profile.Name}
    AdminFunctions.Verify Text Value    Name    ${profile.Name}
    BuiltIn.Run Keyword If    'general' in &{profile}    Profiles.Verify General    &{profile}[general]
    BuiltIn.Run Keyword If    'shortcuts' in &{profile}    Profiles.Verify Shortcuts    &{profile}[shortcuts]
    BuiltIn.Run Keyword If    'destinations' in &{profile}    Profiles.Verify Destinations    &{profile}[destinations] 
    BuiltIn.Run Keyword If    'devices' in &{profile}    Profiles.Verify Devices    &{profile}[devices]    
    Select Button    Cancel 
Device Profile Should Be Remove
    [Arguments]    &{profile}
    Select Button    Profiles
    AdminFunctions.Delete    ${profile.Name}
    
#Fill value keywords
Fill General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Set Fields Value    ${name}    &{fields}[${name}]    
    
Fill Shortcuts
    [Arguments]    ${fields}
    Select Tab    Shortcuts   
    Associate    &{fields}[Associated] 
Fill Destinations
    [Arguments]    ${fields}
    Select Tab    Destinations   
    Associate    &{fields}[Associated] 
Fill Devices
    [Arguments]    ${fields}
    Select Tab    Devices   
    Associate    &{fields}[Associated] 
    
#Verify keywords
Verify General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Verify Fields Value    ${name}    &{fields}[${name}]    
    
Verify Shortcuts
    [Arguments]    ${fields}
    Select Tab    Shortcuts   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
Verify Destinations
    [Arguments]    ${fields}
    Select Tab    Destinations   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
Verify Devices
    [Arguments]    ${fields}
    Select Tab    Devices   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
    