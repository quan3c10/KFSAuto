*** Setting ***
Documentation    Using this resource file to perform all the task related to IE, timeout
...    
#Variables    ../../TestConfig.py
Variables    ../../Pylibs/GetConfigures.py
Library    SeleniumLibrary    
*** Variable ***
${KACPage}		http://${host_name}/Kofax/KFS/Admin/
${KDEPage}		http://${host_name}/Kofax/KFS/ThinClient/
${DocumentDic}    ${CURDIR}${/}Documents
*** Keywords ***
Log Level       
    BuiltIn.Set Log Level    ${log_lv}  
    