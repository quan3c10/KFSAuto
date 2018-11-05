*** Setting ***
Resource    ../TCFunctions.robot

*** Keyword ***
Create And Validation Job
    [Arguments]    &{job}
    Create Job By Shortcut    True    &{job}
    View Job Fields
    Validation Check    &{job}[validation]
    Click Button    ${btntccancel}   
Validation Check
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}  
    :FOR    ${name}    IN    @{names}
    \    Fill And Verify    &{fields}[${name}]   
Fill And Verify
    [Arguments]    ${fields}
    @{keys}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${key}    IN    @{keys} 
    \    Run Keyword If    '${key}'=='Input'   Input    &{fields}[${key}]
    \    ...    ELSE IF    '${key}'=='Select'    Select    &{fields}[${key}]  
    \    ...    ELSE    Verify    &{fields}[${key}]  
Input 
    [Arguments]    ${fields}
    @{keys}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${key}    IN    @{keys}
    \    TCFunctions.Set Text Value    ${key}    &{fields}[${key}]
Select 
    [Arguments]    ${fields}
    @{keys}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${key}    IN    @{keys}
    \    TCFunctions.Select Dropdown Value   ${key}    &{fields}[${key}]  
Verify 
    [Arguments]    ${fields}
    Click Button    ${btnsubmit}
    @{keys}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${key}    IN    @{keys}
    \    Verify Error Message    ${key}    &{fields}[${key}]
    