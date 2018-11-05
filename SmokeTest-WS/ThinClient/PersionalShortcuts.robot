*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
*** Keyword ***
Add Personal Shortcut
    [Arguments]    ${shortcut}
    ${id}=    Get Button ID    ${shortcut.Destination} 
    ${fields}=    Get Button Fields    ${shortcut.Destination}
    Run Keyword If    'Fields' in ${shortcut}    Set Fields Values    ${fields}    &{shortcut}[Fields]                
    ${body}=    Create Body    ${fields}    ${id}    ${shortcut}
    &{res}=    Post    ${KDEPage}shortcut/personal//    body=${body}
    Check Response    ${res}             
Create Body
    [Arguments]    ${fields}    ${id}    ${shortcut}
    ${adminobject}=    Create Dictionary    ID=${id}    Name=${shortcut.Name}
    ${body}=    Create Dictionary    AdminObject=${adminobject}    Fields=${fields}
    [Return]    ${body}       
Verify General
    [Arguments]    ${shortcut}
    ${actual}=    Get Button Fields    ${shortcut.Name}     
    Verify Fields    ${actual}    &{shortcut}[Fields] 
Verify Exist
    [Arguments]    ${shortcut}
    Get Button ID    ${shortcut.Name}  
                              