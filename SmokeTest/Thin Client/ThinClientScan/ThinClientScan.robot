*** Setting ***
Resource    ../TCFunctions.robot
Variables    testdata.py

*** Variable ***
${connectScanner}    "C:\\Program Files\\USB Redirector Client\\usbrdrltsh.exe" -connect -server SQA-KFS2-PC:32032 -vid 0638 -pid 0A5A -usbport 4-4
${disconnectScanner}    "C:\\Program Files\\USB Redirector Client\\usbrdrltsh.exe" -disconnect -server SQA-KFS2-PC:32032 -vid 0638 -pid 0A5A -usbport 4-4
*** Keyword ***
Download And Install WebCapture
    ${path}=    Download Web Capture    http://${HostName}/Kofax/KFS/ThinClient    Kofax.WebCapture.Installer.msi    auth=&{auth}
    ${pass}=    Run Keyword And Return Status    File Should Exist    ${path}    
    Run Keyword If    ${pass}    Run	${path}
    ${exist}=    Run    if exist "C:\\ProgramData\\Kofax\\WebCapture\\Kofax.WebCapture.Host.exe" (echo True) ELSE (echo False)
    Run Keyword If    not ${exist}    Fail    Failed to install Web Capture     
Connect Scanner
    Run    ${connectScanner}
Disconnect Scanner
    Run    ${disconnectScanner}
Configure Scan Settings
    Select Button    TCSettings  
    Select From List By Label    id:ScanWith    AV3852U
    Select From List By Label    id:FeederSource    Flatbed
    Click Button    ${btnOK}
Scan Pages
    Select Button    Scan
    :FOR    ${i}    IN RANGE    6
    \    ${scanned}=    Run Keyword And Return Status    Verify Page Count    1  
    \    Run Keyword If    not ${scanned}    Sleep    1    ELSE    Exit For Loop    
    \    Run Keyword If    ${i}==5    Fail    Unable to scan page          
    Press Key    //body    n      