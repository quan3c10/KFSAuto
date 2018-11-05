*** Setting ***
Resource         ThinClientScan.robot
Resource        ../ActiveJobs/ActiveJobs.robot
Variables        ${CURDIR}${/}testdata.py
#Suite Setup    Test Setup
#Suite Teardown    Clean Data
Default Tags    Shortcuts
*** Test Cases ***
Test Validation Script
    Download And Install WebCapture
    
    
*** Keyword ***
