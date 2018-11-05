*** Setting ***
Library    Collections
Library    XML    
Library    OperatingSystem        
Resource    ../TestResource/CommonConfiguration.robot
Resource    ../AdminConsole/AdminFunctions.robot
Resource    ../Thin Client/TCFunctions.robot
*** Variable ***
#Login page
${txtUsername}    id:userid
${txtPassword}    id:password
${btnLogin}    id:submitspan

#Table objects
${cbSelectAll}    //span[@class='slick-column-name']//descendant::input

#Dialog buttons
${btnYes}    //span[contains(text(),'Yes')]//parent::button
${btnOK}    //span[contains(text(),'OK')]//parent::button

${batchdump}    ${/}${/}${HostName}${/}CaptureSV${/}batchdump

*** Keyword ***
Launch
    [Arguments]    ${page}    ${user}
    SeleniumLibrary.Open Browser    ${page}    ${Browser}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Input Text    ${txtUserName}    ${user.user}
    SeleniumLibrary.Input Text    ${txtPassword}    ${user.password}
    SeleniumLibrary.Click Button    ${btnLogin}
Select All
    SeleniumLibrary.Select Checkbox    ${cbSelectAll}
Unselect All
    SeleniumLibrary.Unselect Checkbox    ${cbSelectAll}
Select Tab
    [Arguments]    ${tab}
    CommonConfiguration.Wait For Page
    SeleniumLibrary.Click Link    ${tb${tab}}
    CommonConfiguration.Wait For Page   
Select Button
    [Arguments]    ${button}
    CommonConfiguration.Wait For Page
    SeleniumLibrary.Click Link    ${btn${button}}
    CommonConfiguration.Wait For Page