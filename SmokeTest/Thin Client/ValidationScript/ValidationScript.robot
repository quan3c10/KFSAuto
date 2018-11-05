*** Setting ***
Resource    ../TCFunctions.robot

*** Keyword ***
Create And Validation Job
    [Arguments]    &{job}
    Create Job By Shortcut    True    &{job}
    View Job Fields
    Validation Check    &{job}[validation]
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
    \    ...    ELSE    Select    &{fields}[${key}] 
Input 
    [Arguments]    ${fields}
    Run Keyword If    'Fill' in ${fields}
    ...    Run Keywords    
    ...    TCFunctions.Set Text Value    ${fields.Name}    ${fields.Fill}
    ...    AND    Tabout Field    //div[contains(text(),'${fields.Name}')]//following::input[1]
    ...    AND    Wait For Page
    Run Keyword If    'Disabled' in ${fields}    Verify Field Disabled    ${fields.Name}       
    Run Keyword If    'Error' in ${fields}    Verify Error Message    ${fields.Name}    ${fields.Error}    
Select 
    [Arguments]    ${fields}
    Run Keyword If    'Selections' in ${fields}    TCFunctions.Verify Dropdown Values    ${fields.Name}    &{fields}[Selections]
    Run Keyword If    'Select' in ${fields}    TCFunctions.Select Dropdown Value    ${fields.Name}    ${fields.Select}   
    Tabout Field    //div[contains(text(),'${fields.Name}')]//following::input[1] 
    Run Keyword If    'Error' in ${fields}    Verify Error Message    ${fields.Name}    ${fields.Error}   

    