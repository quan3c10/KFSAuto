*** Setting ***
Resource    ../AdminFunctions.robot
*** Variable ***
${btnVersion}    id:bar-info
${dgVersion}    id:ui-id-4
${kfsVersion}    id:kfsVersion
${btnLogout}    css:#bar-logoff

*** Keyword ***
Version Should Be Correct
    CommonConfiguration.Wait For Page
    SeleniumLibrary.Click Link    ${btnVersion}
    SeleniumLibrary.Wait Until Element Is Visible    ${dgVersion}
    ${ActualVersion}=    SeleniumLibrary.Get Text    ${kfsVersion}
    SeleniumLibrary.Click Button    ${btnOK}
    BuiltIn.Should Contain    ${ActualVersion}    ${BuildNumber}
    Logout
    SeleniumLibrary.Close All Browsers    