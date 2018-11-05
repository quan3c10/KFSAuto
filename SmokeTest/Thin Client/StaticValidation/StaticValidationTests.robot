*** Setting ***
Resource         StaticValidation.robot
Resource         ../../AdminConsole/Shortcuts/Shortcuts.robot
Resource        ../ActiveJobs/ActiveJobs.robot
Variables        ${CURDIR}${/}testdata.py
Suite Setup    Test Setup
Suite Teardown    Clean Data
Default Tags    Shortcuts
*** Test Cases ***
Test Static Validation
    Launch KDE    &{group1}
    Create And Validation Job    &{job}
    Test TearDown
*** Keywords ***
Test Setup
    Launch KAC
    Create Shortcut    cleanup=True    &{sc}
    Test TearDown
Clean Data
    Launch KAC
    Select Button    Shortcuts
    Clean Up
    Test TearDown
    
    