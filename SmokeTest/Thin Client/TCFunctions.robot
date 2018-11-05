*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
Library    ../../Pylibs/CustomSeleniumLibrary.py        
Resource    ../TestResource/CommonConfiguration.robot
Resource    ActiveJobs/ActiveJobs.robot
Variables    ObjectsMapping.py
*** Keyword ***
Launch KDE
    [Arguments]    &{user}
    Launch    ${KDEPage}    ${user}
Shortcut Should Be Exists
    [Arguments]    ${exists}=True    &{shortcut}
    Select Button    Home  
    Wait For Page
    Run Keyword If    ${exists}    Element Should Be Visible    //div[contains(text(),'${shortcut.Name}')]//ancestor::a[1]
    ...    ELSE    Element Should Not Be Visible    //div[contains(text(),'${shortcut.Name}')]//ancestor::a[1]             
Create Job By Shortcut
    [Arguments]    ${cleanup}=False    &{job} 
    BuiltIn.Run Keyword If    ${cleanup}    Clean Jobs 
    Select Button    Home  
    Click Link    //div[contains(text(),'&{job}[shortcut]')]//ancestor::a[1] 
    Wait For Page       
    Run Keyword If    'images' in &{job}    
    ...    Run Keywords    
    ...    Import Job    &{job}[images]     
    ...    AND
    ...    Rename Job    &{job}[Name]  
Rename Job
    [Arguments]    ${name}
    Click Button    ${btnjobnotes}    
    Input Text    ${txtName}    ${name}
    Click Button    ${btnOK}
    Wait For Page
Select Shortcut For Job
    [Arguments]    ${shortcut}
    Click Button    ${btnselectdes}
    Click Link    //div[contains(text(),'${shortcut}')]//ancestor::a[1] 
    Wait For Page
Select Images By Index 
    [Arguments]    ${start}    ${end}
    ${from}=    Evaluate    ${start} + 1  
    ${to}=    Evaluate    ${end} + 1  
    Click Element    //div[@id='createJob']/child::div[${from}]
    Hold And Click    //div[@id='createJob']/child::div[${to}]    SHIFT
Select Image By Index
    [Arguments]    ${index}
    ${index}=    Evaluate    ${index} + 1  
    ${attr}=    Get Css Property    //div[@id='createJob']/child::div[${index}]/div[1]    border   
    Run Keyword If    'none' in '${attr}'    Click Element    //div[@id='createJob']/child::div[${index}]  
Select Image Tool
    [Arguments]    ${name}
    Mouse Over    ${btn${name}}
    Select Button    ${name}
Verify Page Count
    [Arguments]    ${expect}
    ${all}=    SeleniumLibrary.Get Element Count    //div[@id='createJob']/child::div
    ${actual}=    Evaluate    ${all} - 1
    Run Keyword If    ${actual} != ${expect}    Fail    Actual page count is ${actual} while expect ${expect}    
Close Dialog
    Click Button    ${btnClose}       
Delete
    [Arguments]    ${name}
    CommonConfiguration.Wait For Page
    Select Row    ${name}
    Select Button    TCDelete
    SeleniumLibrary.Click Button    ${btnYes}
    CommonConfiguration.Wait For Page
    SeleniumLibrary.Page Should Not Contain Element    //a[contains(text(),'${name}')]//ancestor::div[2]
Tabout Field
    [Arguments]    ${locator}
    Press Key    ${locator}    \\9
    #Field function keywords
Set Fields Value
    [Arguments]    ${field}    ${value}
    ${pass}=    Run Keyword And Return Status    Evaluate    type(${value})
    ${type}=    Run Keyword If    ${pass}    Evaluate    type(${value}).__name__
    ...    ELSE    Evaluate    type('').__name__         
    BuiltIn.Run Keyword If    '${type}'=='dict'    TCFunctions.Set Multiple Values    ${field}    ${value}
    ...    ELSE    TCFunctions.Set Text Value    ${field}    ${value}
Set Multiple Values
    [Arguments]    ${field}    ${value}    ${kde}=False
    @{keys}=    Collections.Get Dictionary Keys    ${value}
    :FOR    ${key}    IN    @{keys}
    \    BuiltIn.Run Keyword If    '${key}'=='Value'    TCFunctions.Set Text Value    ${field}    ${value.${key}}   
    \    ...    ELSE    TCFunctions.Select Dropdown Value    ${field}    ${value.${key}}
Set Text Value
    [Arguments]    ${field}    ${value}    ${event}=None
    SeleniumLibrary.Input Text    //div[contains(text(),'${field}')]//following::input[1]    ${value}    
    Run Keyword If    ${event}    Simulate Event    //div[contains(text(),'${field}')]//following::input[1]    ${event}        
Select Dropdown Value
    [Arguments]    ${field}    ${value}    ${event}=None
    Click Link    //div[contains(text(),'${field}')]//following::a[1]
    Click Element    //ul/li/a[text()='${value}']   
    Run Keyword If    ${event}    Simulate Event    //div[contains(text(),'${field}')]//following::select[1]    ${event}

#Verify keyword
Verify Fields Value
    [Arguments]    ${field}    ${value}
    ${pass}=    Run Keyword And Return Status    Evaluate    type(${value})
    ${type}=    Run Keyword If    ${pass}    Evaluate    type(${value}).__name__
    ...    ELSE    Evaluate    type('').__name__         
    BuiltIn.Run Keyword If    '${type}'=='dict'    TCFunctions.Verify Multiple Values    ${field}    ${value}
    ...    ELSE    TCFunctions.Verify Text Value    ${field}    ${value}
Verify Multiple Values
    [Arguments]    ${field}    ${value}
    @{keys}=    Collections.Get Dictionary Keys    ${value}
    :FOR    ${key}    IN    @{keys}
    \    BuiltIn.Run Keyword If    '${key}'=='Value'    TCFunctions.Verify Text Value    ${field}    ${value.${key}}  
    \    ...    ELSE IF    '${key}'=='Select'    TCFunctions.Verify Dropdown Values    ${field}    ${value.${key}}   
    \    ...    ELSE IF    '${key}'=='Error'    Verify Error Message    ${field}    ${value.${key}}   
Verify Text Value
    [Arguments]    ${field}    ${value}
    Wait For Page
    SeleniumLibrary.Textfield Value Should Be    //div[contains(text(),'${field}')]//following::input[1]    ${value}
Verify Error Message
    [Arguments]    ${field}    ${error}
    Wait For Page
    SeleniumLibrary.Element Text Should Be    //div[contains(text(),'${field}')]//following::div[1]    ${error}  
Verify Dropdown Values
    [Arguments]    ${field}    ${expect}
    Wait For Page
    ${actual}=    Get List Items    //div[contains(text(),'${field}')]//following::select[1]    True   
    Lists Should Be Equal    ${expect}    ${actual}     
Verify Selected Values
    [Arguments]    ${field}    ${expect}
    List Selection Should Be    //div[contains(text(),'${field}')]//following::select[1]    ${expect}
Verify Field Disabled
    [Arguments]    ${field}
    Wait For Page
    Element Should Be Disabled    //div[contains(text(),'${field}')]//following::input[1]
Verify Batch Created
    [Arguments]    &{batch}
    ${path}=    Catenate    SEPARATOR=    ${batchdump}${/}    ${batch.Name}.xml 
    :FOR    ${i}    IN RANGE    60
    \    ${exists}=    Run Keyword And Return Status    File Should Exist    ${path}
    \    Run Keyword If    ${exists}    
    \    ...    Run Keywords         
    \    ...    Verify Batch Name    ${path}    ${batch.Name} 
    \    ...    AND    Verify Pages Count    ${path}     ${batch.page}   
    \    ...    AND    Verify Fields    ${path}     &{batch}[fields]
    \    ...    AND    Exit For Loop
    \    ...    ELSE    Sleep    1.0       
    Run Keyword If    not ${exists}    Fail    Batch ${batch.Name} is not created after 60 seconds
Verify Batch Name
    [Arguments]    ${path}    ${name}
    ${actual}=    XML.Get Element Attribute    ${path}    Name    Batch    
    Should Be Equal As Strings    ${actual}    ${name}     
Verify Pages Count
    [Arguments]    ${path}    ${pages}
    ${actual}=    XML.Get Element Count    ${path}    .//Page    
    Should Be Equal As Numbers    ${actual}    ${pages}   
Verify Fields
    [Arguments]    ${path}    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    ${actual}=    XML.Get Element Attribute    ${path}    Value    .//*[@Name="${name}"]    
    \    Should Be Equal As Strings    ${actual}    &{fields}[${name}]         