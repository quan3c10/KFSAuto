*** Setting ***
Resource    ../TCFunctions.robot

*** Keyword ***
Create Personal Shortcut
    [Arguments]    &{shortcut}
    Click Create Button    ${shortcut.OldName}  
    TCFunctions.Set Text Value    Name    ${shortcut.Name} 
    BuiltIn.Run Keyword If    'general' in &{shortcut}    TCShortcuts.Fill General    &{shortcut}[general]     
    Click Button    ${btntcsave} 
Edit Personal Shortcut
    [Arguments]    &{shortcut}
    Click Edit Button    ${shortcut.OldName}
    TCFunctions.Set Text Value    Name    ${shortcut.Name} 
    BuiltIn.Run Keyword If    'general' in &{shortcut}    TCShortcuts.Fill General    &{shortcut}[general]    
    Click Button    ${btntcsave} 
Personal Shortcut Is Updated
    [Arguments]    &{shortcut}
    Click Edit Button    ${shortcut.Name}
    TCFunctions.Verify Text Value    Name    ${shortcut.Name} 
    BuiltIn.Run Keyword If    'general' in &{shortcut}    TCShortcuts.Verify General    &{shortcut}[general]  
    Click Button    ${btntccancel} 
Personal Shortcut Is Deleted
    [Arguments]    &{shortcut}
    Click Delete Button    ${shortcut.Name}
    Element Should Not Be Visible    //div[contains(text(),'${shortcut.Name}')] 
Create And Verify Coversheet
    [Arguments]    &{shortcut}
    Select Button    Home  
    Wait For Page
    Mouse Over    //div[contains(text(),'${shortcut.Name}')]//following::a[2]
    Click Link    //div[contains(text(),'${shortcut.Name}')]//following::a[2]
    Wait Until Element Is Visible    //span[contains(text(),'Coversheet')]  
    BuiltIn.Run Keyword If    'general' in &{shortcut}    TCShortcuts.Verify General    &{shortcut}[general]  
    Click Button    ${btntccancel}  

Click Create Button
    [Arguments]    ${scname}
    Select Button    Home
    Wait For Page
    Mouse Over    //div[contains(text(),'${scname}')]//following::a[3]
    Click Link    //div[contains(text(),'${scname}')]//following::a[3]
    Wait Until Element Is Visible    //span[contains(text(),'personal')]

Click Edit Button
    [Arguments]    ${scname}
    Select Button    Home
    Wait For Page
    Mouse Over    //div[contains(text(),'${scname}')]//following::a[3]
    Click Link    //div[contains(text(),'${scname}')]//following::a[3]
    Wait Until Element Is Visible    //span[contains(text(),'Personal')]

Click Delete Button
    [Arguments]    ${scname}
    Select Button    Home
    Wait For Page
    Mouse Over    //div[contains(text(),'${scname}')]//following::a[4]
    Click Link    //div[contains(text(),'${scname}')]//following::a[4]
    Click Button    ${btnYes}
    Wait For Page
       
#Fill value keywords
Fill General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    TCFunctions.Set Fields Value    ${name}    &{fields}[${name}]   

#Verify keywords
Verify General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    TCFunctions.Verify Fields Value    ${name}    &{fields}[${name}]  
    