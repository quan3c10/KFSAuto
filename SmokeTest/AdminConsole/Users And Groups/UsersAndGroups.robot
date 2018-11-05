*** Setting ***
Resource    ../AdminFunctions.robot

*** Variable ***
#General Tab
${txtUserID}    id:edit-user-ID
${txtUserDes}    id:edit-user-Description
${txtUser}    id:edit-user-Name
${txtGroupDes}    id:edit-group-Description
${txtGroup}    id:edit-group-Name

*** Keyword ***
Edit Users
    [Arguments]    &{user}
    Select Button    Users
    Edit User    ${user.ID}
    AdminFunctions.Verify Text Value    Name    ${user.Name} 
    AdminFunctions.Verify Text Value    ID    ${user.ID}
    BuiltIn.Run Keyword If    'permissions' in &{user}    UsersAndGroups.Fill Permissions    &{user}[permissions]     
    Select Button    Save 
Users Should Be
    [Arguments]    &{user}
    Select Button    Users
    Edit User    ${user.ID}
    AdminFunctions.Verify Text Value    Name    ${user.Name}
    AdminFunctions.Verify Text Value    ID    ${user.ID}
    BuiltIn.Run Keyword If    'general' in &{user}    UsersAndGroups.Verify General    &{user}[general]
    BuiltIn.Run Keyword If    'members' in &{user}    UsersAndGroups.Verify Members    &{user}[members]
    BuiltIn.Run Keyword If    'permissions' in &{user}    UsersAndGroups.Verify Permissions    &{user}[permissions]    
    Select Button    Cancel 
Edit Groups
    [Arguments]    &{group}
    Select Button    Groups
    Edit    ${group.OldName}
    AdminFunctions.Verify Text Value    Name    ${group.Name} 
    BuiltIn.Run Keyword If    'permissions' in &{group}    UsersAndGroups.Fill Permissions    &{group}[permissions]  
    BuiltIn.Run Keyword If    'destinations' in &{group}    UsersAndGroups.Fill Destinations    &{group}[destinations] 
    BuiltIn.Run Keyword If    'shortcuts' in &{group}    UsersAndGroups.Fill Shortcuts    &{group}[shortcuts]    
    Select Button    Save 
Groups Should Be
    [Arguments]    &{group}
    Select Button    Groups
    Edit    ${group.Name}
    AdminFunctions.Verify Text Value    Name    ${group.Name}
    BuiltIn.Run Keyword If    'general' in &{group}    UsersAndGroups.Verify General    &{group}[general]
    BuiltIn.Run Keyword If    'members' in &{group}    UsersAndGroups.Verify Members    &{group}[members]
    BuiltIn.Run Keyword If    'permissions' in &{group}    UsersAndGroups.Verify Permissions    &{group}[permissions]   
    BuiltIn.Run Keyword If    'destinations' in &{group}    UsersAndGroups.Verify Destinations    &{group}[destinations] 
    BuiltIn.Run Keyword If    'shortcuts' in &{group}    UsersAndGroups.Verify Shortcuts    &{group}[shortcuts]    
    Select Button    Cancel 
    
#Fill value keywords
Fill Permissions
    [Arguments]    ${fields}
    Select Tab    Permissions   
    Associate    &{fields}[Associated]     
    
Fill Destinations
    [Arguments]    ${fields}
    Select Tab    Destinations   
    Associate    &{fields}[Associated] 
Fill Shortcuts
    [Arguments]    ${fields}
    Select Tab    Shortcuts  
    Associate    &{fields}[Associated] 
Edit User
    [Arguments]    ${userID}
    Click Link    //div[text()='${userID}']//preceding::a[1]
    Wait For Page
#Verify keywords
Verify General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Verify Fields Value    ${name}    &{fields}[${name}]    
    
Verify Destinations
    [Arguments]    ${fields}
    Select Tab    Destinations   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
Verify Permissions
    [Arguments]    ${fields}
    Select Tab    Permissions   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
Verify Shortcuts
    [Arguments]    ${fields}
    Select Tab    Shortcuts   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Associate Options    &{fields}[${name}]
    \    ...    ELSE    Verify Associate Options    &{fields}[${name}]    False
Verify Members
    [Arguments]    ${fields}
    Select Tab    Member   
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    '${name}'=='Associated'   Verify Member    &{fields}[${name}]
    \    ...    ELSE    Verify Member    &{fields}[${name}]    False
    