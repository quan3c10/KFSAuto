*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
*** Keyword ***
Get Settings
    [Arguments]    ${namespace}    ${name}
    &{res}=    Get    ${KACPage}SettingsService/settings   
    @{settings}=    Convert To List    ${res.body['SettingsList']}
    ${return}=    Set Variable    None     
    :FOR    ${prop}    IN    @{settings}        
    \    ${return}=    Run Keyword And Return If    '${prop.Namespace}'=='${namespace}' and '${prop.Name}'=='${name}'    Get Setting In List    ${prop}    ${settings}
    \    Exit For Loop If    ${return}!=None
    [Return]    ${return}    
Edit Settings
    [Arguments]    ${namespace}    ${name}    ${value} 
    &{prop}=    Get Settings    ${namespace}    ${name}
    ${data}=    Create Dictionary    Category=${prop.Category}    Description=${prop.Description}    IsObscured=${prop.IsObscured}
    ...    Name=${prop.Name}    Namespace=${prop.Namespace}    Value=${value}    __internal_is_changed=True
    ...    id=${prop.id}
    ${list}=    Create List    ${data}
    ${body}=    Create Dictionary    AdminObjects=${list}
    &{res}=    Put    ${KACPage}SettingsService/Settings//    body=${body}
    Check Response    &{res}
Get Setting In List
    [Arguments]    ${property}    ${list}
    ${id}=    Get Index From List    ${list}    ${property}      
    Set To Dictionary    ${property}    id=${id}
    [Return]    ${property}
                    