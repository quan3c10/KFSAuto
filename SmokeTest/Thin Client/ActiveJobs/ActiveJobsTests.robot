*** Setting ***
Resource    ActiveJobs.robot
Test Teardown    Test TearDown    
Test Setup    Launch KDE    &{group1}
Variables    ${CURDIR}${/}testdata.py
Default Tags    Devices
*** Test Cases ***
Test Import EDoc
    Create Job    cleanup=True    &{edoc} 
    Rename Job By Row    0    &{edoc}[Name] 
    Verify Job Exist    &{edoc}[Name]   
    Clean Jobs    
Test Merge Jobs
    Create Job   cleanup=True    &{job1} 
    Rename Job By Row    0    &{job1}[Name]
    Create Job   &{job2} 
    Rename Job By Row    0    &{job2}[Name]
    Select Job    &{job1}[Name]
    Select Job    &{job2}[Name]
    Select Button    Merge
    Verify Job Exist    &{job2}[Name] 
    Verify Job Exist    &{job1}[Name]    False  
Test Delete Job
    Job Should Be Remove    &{job2}