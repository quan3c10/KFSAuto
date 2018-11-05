*** Setting ***
Resource    ../TestResource/CommonConfiguration.robot
Resource    ../TestResource/CommonFunctions.robot
Resource    ../MFPEmulator/MFPEmulator.robot
Variables    testdata.py
Suite Setup    Log Level
*** Variable ***
&{dic}    first=True  second='false'
${second}    'false'
${1}    C:\\ProgramData\\Kofax\\WebCapture\\Kofax.WebCapture.Host.exe
${2}    IF EXIST "C:\\ProgramData\\Kofax\\WebCapture\\Kofax.WebCapture.Host.exe" (echo True) ELSE (echo False)
*** Test Cases ***  
Test
    Ping Server      
Test1
    Check
*** Keyword ***
Check
    ${res}=    Get    ${KDEPage}auth//    {"UserID":"admin","Password":"k00fax"}
    Log To Console    ${res}        
    #Log To Console    ${res.body['ErrorCode']}     
    Log To Console    ${res.status}    