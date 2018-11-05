*** Setting ***
Resource         ValidationScript.robot
Resource         ../../AdminConsole/Shortcuts/Shortcuts.robot
Resource        ../ActiveJobs/ActiveJobs.robot
Variables        ${CURDIR}${/}testdata.py
Suite Setup    Test Setup
Suite Teardown    Clean Data
Default Tags    Shortcuts
*** Test Cases ***
Test Validation Script
    Launch KDE    &{group1}
    Create And Validation Job    &{job}
    Click Button    ${btnsubmit}
    Test TearDown
Test Batches Created
    Verify Batch Created    &{batch}
*** Keywords ***
Test Setup
    Launch KAC
    Modify Advanced Settings    kc.properties    batchname.indexfield    Country
    Create Shortcut    cleanup=True    &{sc}
    Test TearDown
Clean Data
    Launch KAC
    Select Button    Shortcuts
    Clean Up
    Test TearDown
    
    