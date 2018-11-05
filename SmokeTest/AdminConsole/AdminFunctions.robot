*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
Resource    ../TestResource/CommonConfiguration.robot
Variables    ObjectsMapping.py

*** Keyword ***
Launch KAC
    Launch    ${KACPage}    user=&{admin}       
Select Row
    [Arguments]    ${name}
    Select All
    Unselect All
    SeleniumLibrary.Select Checkbox    //a[contains(text(),'${name}')]//ancestor::div[2]//descendant::input
Clean Up
    CommonConfiguration.Wait For Page
    ${exists}=    BuiltIn.Run Keyword And Return Status    SeleniumLibrary.Element Should Be Visible    css:.slick-row
    BuiltIn.Run Keyword If    ${exists}    AdminFunctions.Delete All 
Edit
    [Arguments]    ${name}
    CommonConfiguration.Wait For Page
    SeleniumLibrary.Click Link    link:${name}
    CommonConfiguration.Wait For Page   
Modify Advanced Settings
    [Arguments]    ${namespace}    ${name}    ${value}
    Select Button    Settings   
    Wait For Page  
    Select Tab    Advanced
    Click Element    ${txtsearch1}
    Input Text    ${txtsearch1}    ${namespace}
    Input Text    ${txtsearch2}    ${name}
    Click Element    //div[@id='myGrid']/div[4]//div[contains(@class,'r3')]
    Input Text    //div[@id='myGrid']/div[4]//div[contains(@class,'r3')]/input    ${value}
    Click Link    ${btnSave}
    Handle Alert  
Delete
    [Arguments]    ${name}
    CommonConfiguration.Wait For Page
    Select Row    ${name}
    SeleniumLibrary.Click Link    ${btnDelete}
    SeleniumLibrary.Click Button    ${btnYes}
    CommonConfiguration.Wait For Page
    SeleniumLibrary.Page Should Not Contain Element    //a[contains(text(),'${name}')]//ancestor::div[2]
Delete All
    [Arguments]
    Select All
    Select Button    Delete
    SeleniumLibrary.Wait Until Element Is Visible    ${btnYes}
    SeleniumLibrary.Click Button    ${btnYes}
    
    #Field function keywords
Set Fields Value
    [Arguments]    ${field}    ${value}
    ${pass}=    Run Keyword And Return Status    Evaluate    type(${value})
    ${type}=    Run Keyword If    ${pass}    Evaluate    type(${value}).__name__
    ...    ELSE    Evaluate    type('').__name__         
    BuiltIn.Run Keyword If    '${type}'=='bool'    Set Checkbox    ${field}    ${value}
    ...    ELSE IF    '${type}'=='dict'    AdminFunctions.Set Multiple Values    ${field}    ${value}
    ...    ELSE    AdminFunctions.Set Text Value    ${field}    ${value}
Set Multiple Values
    [Arguments]    ${field}    ${value}
    @{keys}=    Collections.Get Dictionary Keys    ${value}
    :FOR    ${key}    IN    @{keys}
    \    BuiltIn.Run Keyword If    '${key}'=='Value'    AdminFunctions.Set Text Value    ${field}    ${value.${key}}   
    \    ...    ELSE IF    '${key}'=='Select'    AdminFunctions.Select Dropdown Value    ${field}    ${value.${key}}  
    \    ...    ELSE    Set Visibility    ${field}    ${value.${key}}  
Set Text Value
    [Arguments]    ${field}    ${value}
    SeleniumLibrary.Input Text    //label[contains(text(),'${field}')]//following::input[1]    ${value}
Select Dropdown Value
    [Arguments]    ${field}    ${value}
    SeleniumLibrary.Select From List By Label    //label[contains(text(),'${field}')]//following::select[1]    ${value}    
Set Checkbox
    [Arguments]    ${field}    ${value}
    BuiltIn.Run Keyword If    ${value}    SeleniumLibrary.Select Checkbox    //label[contains(text(),'${field}')]//preceding::input[1]
    ...    ELSE    SeleniumLibrary.Unselect Checkbox    //label[contains(text(),'${field}')]//preceding::input[1]
Set Visibility
    [Arguments]    ${fields}    ${boxes}
    @{names}=    Collections.Get Dictionary Keys    ${boxes}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    &{boxes}[${name}]    SeleniumLibrary.Select Checkbox   //label[contains(text(),'${fields}')]//following::tr[2]//label[contains(text(),'${name}')]//preceding::input[1]    
    \    ...    ELSE    SeleniumLibrary.Unselect Checkbox    //label[contains(text(),'${fields}')]//following::tr[2]//label[contains(text(),'${name}')]//preceding::input[1]
#For select box only
Associate
    [Arguments]    ${options}
    Select All From List    ${bxAssociate}
    Click Button    ${btnUnassociate}    
    Run Keyword If    ${options}    SeleniumLibrary.Select From List By Label    ${bxAvailable}    @{options}
    Click Button    ${btnAssociate}
  
#Verify keyword
Verify Fields Value
    [Arguments]    ${field}    ${value}
    ${pass}=    Run Keyword And Return Status    Evaluate    type(${value})
    ${type}=    Run Keyword If    ${pass}    Evaluate    type(${value}).__name__
    ...    ELSE    Evaluate    type('').__name__         
    BuiltIn.Run Keyword If    '${type}'=='bool'    Verify Checkbox    ${field}    ${value}
    ...    ELSE IF    '${type}'=='dict'    AdminFunctions.Verify Multiple Values    ${field}    ${value}
    ...    ELSE    AdminFunctions.Verify Text Value    ${field}    ${value}
Verify Multiple Values
    [Arguments]    ${field}    ${value}
    @{keys}=    Collections.Get Dictionary Keys    ${value}
    :FOR    ${key}    IN    @{keys}
    \    BuiltIn.Run Keyword If    '${key}'=='Value'    AdminFunctions.Verify Text Value    ${field}    ${value.${key}}    
    \    ...    ELSE IF    '${key}'=='Select'    AdminFunctions.Verify Dropdown Value    ${field}    ${value.${key}}
    \    ...    ELSE    Verify Visibility    ${field}    ${value.${key}}  
Verify Text Value
    [Arguments]    ${field}    ${value}
    SeleniumLibrary.Textfield Value Should Be    //label[contains(text(),'${field}')]//following::input[1]    ${value}
Verify Dropdown Value
    [Arguments]    ${field}    ${value}
    SeleniumLibrary.List Selection Should Be    //label[contains(text(),'${field}')]//following::select[1]    ${value} 
Verify Checkbox
    [Arguments]    ${field}    ${value}
    BuiltIn.Run Keyword If    ${value}    SeleniumLibrary.Checkbox Should Be Selected    //label[contains(text(),'${field}')]//preceding::input[1]
    ...    ELSE    SeleniumLibrary.Checkbox Should Not Be Selected    //label[contains(text(),'${field}')]//preceding::input[1]
Verify Visibility
    [Arguments]    ${fields}    ${boxes}
    @{names}=    Collections.Get Dictionary Keys    ${boxes}
    :FOR    ${name}    IN    @{names}
    \    BuiltIn.Run Keyword If    &{boxes}[${name}]    SeleniumLibrary.Checkbox Should Be Selected   //label[contains(text(),'${fields}')]//following::tr[2]//label[contains(text(),'${name}')]//preceding::input[1]    
    \    ...    ELSE    SeleniumLibrary.Checkbox Should Not Be Selected    //label[contains(text(),'${fields}')]//following::tr[2]//label[contains(text(),'${name}')]//preceding::input[1]  
Verify Member
    [Arguments]    ${members}    ${associated}=True
    :FOR    ${member}    IN    @{members}  
    \    Run Keyword If    ${associated}    Element Should Be Visible    //a[text()='${member}']  
    \    ...    ELSE    Page Should Not Contain Element    //a[text()='${member}']
Verify Associate Options
    [Arguments]    ${options}    ${isassociated}=True
    @{available}=    Get List Items    ${bxavailable} 
    @{associated}=    Get List Items    ${bxassociate}     
    Run Keyword If    ${isassociated}    List Should Contain Sub List    ${associated}    ${options}      
    ...    ELSE    List Should Contain Sub List    ${available}    ${options}              