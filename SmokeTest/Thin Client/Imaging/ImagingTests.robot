*** Setting ***
Resource    Imaging.robot
Resource    ../ActiveJobs/ActiveJobs.robot
Variables    ${CURDIR}${/}testdata.py
Suite Setup    Test Setup
Suite Teardown    Clean Data
Default Tags    Imaging
*** Test Cases ***
Test Zoom    
    Edit Image By Index    1
    Zoom In And Verify
    Zoom Out And Verify
    Zoom Fit And Verify
    Zoom Normal And Verify
    Close Dialog
    
Test Navigation
    Import Job    &{job}[images]
    Edit Image By Index    1
    Last Page
    Verify Current Page    4    4
    First Page
    Verify Current Page    1    4
    Next Page
    Verify Current Page    2    4
    Previous Page
    Verify Current Page    1    4
    Close Dialog
    
Test Edit Image Tools
    Edit Image By Index    1
    Rotate Left And Verify
    Rotate Right And Verify
    Redact Black    
    Verify Redact Black
    Redact White
    Verify Redact White
    Annotate    Annotated Text
    Verify Annotate
    Close Dialog

Test Add Page
    Import Job    &{job}[images]
    Verify Page Count    6
    Import Job    &{job}[images]
    Verify Page Count    8
    
Test Delete Page
    Select Images By Index    5    8
    Select Button    TCDelete
    Click Button    ${btnYes}
    Wait For Page
    Verify Page Count    4
    
Test Split Job
    Select Image By Index    1
    Select Button    Split
    Wait For Page
    Rename Job    Job1b
    Edit Job    &{job}[Name]
    Verify Page Count    1
    Edit Job    Job1b
    Verify Page Count    3
    
Test DownLoad
    Edit Job    &{job}[Name]
    Select Button    Download
    Sleep    2
    Document Should Be Downloaded    
    
*** Keywords ***
Test Setup
    Launch KDE    &{group1}
    Create Job By Shortcut    cleanup=True    &{job}
    Rename Job    &{job}[Name]
Clean Data
    Clean Jobs
    Test TearDown