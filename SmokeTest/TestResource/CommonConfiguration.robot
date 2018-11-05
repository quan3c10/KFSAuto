*** Setting ***
Documentation    Using this resource file to perform all the task related to IE, timeout
...    
Library    SeleniumLibrary    timeout=15.0    implicit_wait=0.3    screenshot_root_directory=${Screenshot}
Resource    ../AdminConsole/General/General.robot
Variables    ../../TestConfig.py
*** Variable ***
${Screenshot}    ${OUTPUT_DIR}${/}ScreenShots
${KACPage}		http://${HostName}/Kofax/KFS/Admin/login.html
${KDEPage}		http://${HostName}/Kofax/KFS/ThinClient/login.html
${DocumentDic}    ${CURDIR}${/}Documents
    
*** Keyword ***
Test TearDown
    Logout
    SeleniumLibrary.Close All Browsers
    
Wait For Page
    SeleniumLibrary.Wait Until Page Does Not Contain Element    css:.blockUI  
Logout
    Wait For Page
    SeleniumLibrary.Click Link    ${btnLogout}    