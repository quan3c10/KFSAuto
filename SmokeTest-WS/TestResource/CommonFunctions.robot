*** Setting ***
Library    REST    ssl_verify=false       
Library    BuiltIn       
Library    Collections 
Resource    ../TestResource/CommonConfiguration.robot
Variables    headers.py
*** Keyword ***
Login
    [Arguments]    ${page}    ${user} 
    ${auth}=    Parse User    ${user}
    &{res}=    Put    ${page}auth//    ${auth}    
    Check Response    ${res} 
    Run Keyword If    '${page}'=='${KACPage}'     Set Headers    {"Cookie": "KFS_AUTH_ADMIN=${res.body['SessionID']}"} 
    ...    ELSE    Set Headers    {"Cookie": "KFS_AUTH_THINCLIENT=${res.body['SessionID']}"}
    Set Headers    {"Accept-Language":"en-US,en;q=0.9"}
    Set Global Variable    ${sessionID}    ${res.body['SessionID']}
Logout
    [Arguments]    ${page}
    &{res}=    Run Keyword If    '${page}'=='${KACPage}'    Put    ${page}logout//    body={"request" : {}}    
    ...    ELSE    Get    ${page}logout//
    Check Response    ${res}
Check Response
    [Arguments]    ${response}
    Run Keyword If    ${response.status}!=200    Fail    Invalid request, the response status is ${response.status}     
    Run Keyword If    ${response.body['ErrorCode']}!=0    Fail    Response return ErrorCode ${response.body['ErrorCode']} with Error "${response.body['ErrorMessage']}"
Parse User
    [Arguments]    ${user}
    ${return}=    Create Dictionary    UserID=${user.UserID}    Password=${user.Password}
    [Return]    ${return}
Is Available
    [Arguments]    ${which}    ${value}    ${list}
    :FOR    ${instance}    IN    @{list}
    \    ${result}=    Set Variable If    '&{instance}[${which}]' == '${value}'    ${instance}
    \    Exit For Loop If    ${result}
    Run Keyword If    ${result}==None    Fail    The ${which} with value "${value}" is not in available list     
    [Return]    ${result}      
Is Associated
    [Arguments]    ${which}    ${value}    ${list}
    :FOR    ${instance}    IN    @{list}
    \    ${result}=    Set Variable If    '&{instance}[${which}]' == '${value}'    True
    \    Exit For Loop If    ${result}
    Run Keyword If    ${result}==None    Fail    The ${which} with value "${value}" is not in associsated list
    ...    ELSE    Log    The ${which} with value "${value}" is in associsated list    
Set Fields Values
    [Arguments]    ${fields}    ${values}
    ${keys}=    Get Dictionary Keys    ${values}    
    :FOR    ${key}    IN    @{keys}
    \    Set Field Value    ${fields}    ${key}    &{values}[${key}]  
Set Field Value
    [Arguments]    ${fields}    ${name}    ${value}   
    :FOR    ${field}    IN    @{fields}
    \    Run Keyword If    '${field.DisplayName}'=='${name}'    Set Suggested Value    ${field}    ${value}  
Set Suggested Value
    [Arguments]    ${field}    ${value} 
    ${empty}=    Create List    
    ${suggested}=    Run Keyword If    'SuggestedValues' in ${field}     Get From Dictionary    ${field}    SuggestedValues
    Run Keyword If    ${suggested}!=${empty}    Set Value By Suggested    ${field}    ${suggested}    ${value}    
    ...    ELSE    Set Value    ${field}    ${value} 
Set Value By Suggested
    [Arguments]    ${field}    ${suggested}    ${display} 
    :FOR    ${suggest}    IN    @{suggested} 
    \    Run Keyword If    '${suggest.DisplayValue}'=='${display}'    Set Value    ${field}    ${suggest}  
Set Value
    [Arguments]    ${field}    ${suggest}    
    ${pass}=    Run Keyword And Return Status    Evaluate    type(${suggest})
    ${type}=    Run Keyword If    ${pass}    Evaluate    type(${suggest}).__name__
    ...    ELSE    Evaluate    type('').__name__   
    Run Keyword If    '${type}'=='dict'    Set To Dictionary    &{field}[FieldValue]    DisplayValue=${suggest.DisplayValue}
    ...    ELSE     Set To Dictionary    &{field}[FieldValue]    DisplayValue=${suggest}
    Run Keyword If    '${type}'=='dict'    Set To Dictionary    &{field}[FieldValue]    Value=${suggest.Value}
    ...    ELSE     Set To Dictionary    &{field}[FieldValue]    Value=${suggest}
Verify Fields
    [Arguments]    ${actual}    ${expect}
    ${keys}=    Get Dictionary Keys    ${expect}
    ${name}=    Get From List    ${keys}    0
    Verify Fields Values    ${actual}    ${name}    &{expect}[${name}]    
Verify Fields Values
    [Arguments]    ${fields}    ${name}    ${value}
    :FOR    ${field}    IN    @{fields}
    \     Run Keyword If    '${field.DisplayName}'=='${name}'    Should Be Equal    ${field.FieldValue['DisplayValue']}    ${value}      
       
Get Button Fields
    [Arguments]    ${name}
    ${button}=    Get Button    ${name}
    ${body}=    Create Dictionary    Button=${button}
    &{res}=    Post    ${KDEPage}button/configuration//    body=${body}   
    Check Response    ${res}
    [Return]    ${res.body['Fields']}
Get Button
    [Arguments]    ${name}
    &{res}=    Put    ${KDEPage}configuration//    body={}
    Check Response    ${res} 
    ${buttons}=    Convert To List    ${res.body['Buttons']} 
    :FOR    ${button}    IN    @{buttons}        
    \    ${return}=    Run Keyword If    '${button.Name}'=='${name}'    Convert To Dictionary    ${button}
    \    Exit For Loop If    ${return}!=None
    [Return]    ${return}  
Get Button ID
    [Arguments]    ${name}
    &{button}=    Get Button    ${name}
    Run Keyword If    ${button}==None    Fail    The shortcut with name "${name}" does not exists.  
    [Return]    ${button.ButtonID}