*** Setting ***
Resource    ../TCFunctions.robot  

*** Keyword ***
Create Job
    [Arguments]    ${cleanup}=False    &{job}  
    BuiltIn.Run Keyword If    ${cleanup}    Clean Jobs   
    BuiltIn.Run Keyword If    'images' in &{job}    Import Job    &{job}[images] 
Job Should Be Remove
    [Arguments]    &{job} 
    Select Button    ActiveJobs 
    Delete Job    &{job}[Name]
    
#Create and Edit keywords 
Import Job
    [Arguments]    ${image}
    Select Button    Import
    Choose File    id:fileUpload    ${DocumentDic}${/}${image}
    Click Button    ${btnOK} 
    Wait For Page 
Rename Job By Row
    [Arguments]    ${row}    ${name}
    Click Element    //div[@row=${row}]//following::div[3]
    Input Text    //div[@row=${row}]//following::div[3]//child::input[1]    ${name}
    Press Key    //div[@row=${row}]//following::div[3]//child::input[1]    \\9
    Wait For Page
Edit Job
    [Arguments]    ${name}
    Select Button    ActiveJobs 
    Click Link    //div[text()='${name}']//preceding::a[1]
    Wait For Page
Select Job
    [Arguments]    ${name}
    SeleniumLibrary.Select Checkbox    //div[contains(text(),'${name}')]//preceding::div[3]//input
View Job Fields
    Select Button    SubmitPanel   
Clean Jobs
    CommonConfiguration.Wait For Page  
    Select Button    ActiveJobs 
    ${exists}=    BuiltIn.Run Keyword And Return Status    Xpath Should Match X Times    //div[contains(@class,'slick-row')]    1        
    BuiltIn.Run Keyword If    not ${exists}    ActiveJobs.Delete All
Delete Job
    [Arguments]    ${name}
    CommonConfiguration.Wait For Page
    Select Job    ${name}
    SeleniumLibrary.Click Link    ${btnTCDelete}
    SeleniumLibrary.Click Button    ${btnYes}
    CommonConfiguration.Wait For Page
    SeleniumLibrary.Page Should Not Contain Element    //div[contains(text(),'${name}')] 
Delete All
    [Arguments]
    Select All
    Select Button    TCDelete
    SeleniumLibrary.Wait Until Element Is Visible    ${btnYes}
    SeleniumLibrary.Click Button    ${btnYes}  
#Verify keywords
Verify Job Exist
    [Arguments]    ${name}    ${exist}=True
    Run Keyword If    ${exist}    Element Should Be Visible    //div[contains(text(),'${name}')]  
    ...    ELSE    Element Should Not Be Visible    //div[contains(text(),'${name}')]          