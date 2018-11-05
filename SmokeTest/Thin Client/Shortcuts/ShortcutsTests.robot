*** Setting ***
Resource         TCShortcuts.robot
Resource         ../../AdminConsole/Shortcuts/Shortcuts.robot
Resource        ../ActiveJobs/ActiveJobs.robot
Variables        ${CURDIR}${/}testdata.py
Suite Setup    Test Setup
Suite Teardown    Clean Data
Default Tags    Shortcuts
*** Test Cases ***
Test Group Shortcut
    Launch KDE    &{group1}
    Shortcut Should Be Exists    &{sc1}    
    Shortcut Should Be Exists     exists=False    &{sc2}
Test Create Job By Shortcut
    Create Job    cleanup=True    &{job1}
    Rename Job By Row    0    &{job1}[Name]
    Select Job    &{job1}[Name]
    View Job Fields
    Select Shortcut For Job    &{job1}[shortcut]  
    TCShortcuts.Verify General    &{scverify}[general]   
    Click Button    ${btnSubmit}
Test Create Personal Shortcut
    Create Personal Shortcut    &{psc1}
    Personal Shortcut Is Updated    &{psc1verify}
    Edit Personal Shortcut    &{psc2}
Test Create Job With Personal Shortcut
    Create Job By Shortcut    &{job2}
    View Job Fields
    TCShortcuts.Verify General    &{psc2}[general]  
    Click Button    ${btnSubmit} 
Test Rename Personal Shortcut
    Edit Personal Shortcut    &{psc1edit}
    Shortcut Should Be Exists    &{psc1edit}  
    Shortcut Should Be Exists    &{psc1}     exists=False 
Test Delete Personal Shortcut
    Personal Shortcut Is Deleted     &{psc1edit}
Test Coversheet
    Create And Verify Coversheet    &{coversheet}
    Test TearDown
Test Batches Created
    Verify Batch Created    &{batch1}
    Verify Batch Created    &{batch2}
*** Keywords ***
Test Setup
    Launch KAC
    Modify Advanced Settings    kc.properties    batchname.indexfield    BF1 Char100
    Create Shortcut    cleanup=True    &{sc1}
    Create Shortcut    &{sc2}
    Test TearDown
Clean Data
    Launch KAC
    Select Button    Shortcuts
    Clean Up
    Test TearDown
    
    