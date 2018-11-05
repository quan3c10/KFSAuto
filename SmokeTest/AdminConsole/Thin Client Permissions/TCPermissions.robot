*** Setting ***
Resource    ../AdminFunctions.robot
*** Variable ***
#General Tab
${txtName}    id:edit-role-Name
${txtDes}    id:edit-role-Description

*** Keyword ***
Create TC Permission
    [Arguments]    ${cleanup}=False    &{permission}
    Select Button    Permissions
    BuiltIn.Run Keyword If    ${cleanup}    Clean Up  
    Select Button    Create
    AdminFunctions.Set Text Value    Name    ${permission.Name} 
    BuiltIn.Run Keyword If    'general' in &{permission}    TCPermissions.Fill General    &{permission}[general]
    BuiltIn.Run Keyword If    'users' in &{permission}    TCPermissions.Fill Users    &{permission}[users]
    BuiltIn.Run Keyword If    'groups' in &{permission}    TCPermissions.Fill Groups    &{permission}[groups] 
    BuiltIn.Run Keyword If    'activities' in &{permission}    TCPermissions.Fill Activities    &{permission}[activities]        
    Select Button    Save 
Edit TC Permission
    [Arguments]    &{permission}
    Select Button    Permissions
    Edit    ${permission.OldName}
    AdminFunctions.Set Text Value    Name    ${permission.Name} 
    BuiltIn.Run Keyword If    'general' in &{permission}    TCPermissions.Fill General    &{permission}[general]
    BuiltIn.Run Keyword If    'users' in &{permission}    TCPermissions.Fill Users    &{permission}[users]
    BuiltIn.Run Keyword If    'groups' in &{permission}    TCPermissions.Fill Groups    &{permission}[groups] 
    BuiltIn.Run Keyword If    'activities' in &{permission}    TCPermissions.Fill Activities    &{permission}[activities]    
    Select Button    Save 
TC Permission Should Be
    [Arguments]    &{permission}
    Select Button    Permissions
    Edit    ${permission.Name}
    AdminFunctions.Verify Text Value    Name    ${permission.Name}
    BuiltIn.Run Keyword If    'general' in &{permission}    TCPermissions.Verify General    &{permission}[general]
    BuiltIn.Run Keyword If    'users' in &{permission}    TCPermissions.Verify Users    &{permission}[users]
    BuiltIn.Run Keyword If    'groups' in &{permission}    TCPermissions.Verify Groups    &{permission}[groups] 
    BuiltIn.Run Keyword If    'activities' in &{permission}    TCPermissions.Verify Activities    &{permission}[activities]    
    Select Button    Cancel 
TC Permission Should Be Remove
    [Arguments]    &{permission}
    Select Button    Permissions
    AdminFunctions.Delete    ${permission.Name}
    
#Fill value keywords
Fill General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Set Fields Value    ${name}    &{fields}[${name}]    
    
Fill Users
    [Arguments]    ${fields}
    Select Tab    Users   
    Associate    &{fields}[Associated] 
Fill Groups
    [Arguments]    ${fields}
    Select Tab    Groups  
    Associate    &{fields}[Associated] 
Fill Activities
    [Arguments]    ${fields}
    Select Tab    Activities   
    Associate    &{fields}[Associated] 
    
#Verify keywords
Verify General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Verify Fields Value    ${name}    &{fields}[${name}]    
    
Verify Users
    [Arguments]    ${fields}
    Select Tab    Users   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
Verify Groups
    [Arguments]    ${fields}
    Select Tab    Groups   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
Verify Activities
    [Arguments]    ${fields}
    Select Tab    Activities   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]    True
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
    