*** Setting ***
Resource    ../TCFunctions.robot  

*** Keyword ***
Edit Image By Index
    [Arguments]    ${index}
    Select Image By Index    ${index}
    Select Button    TCEdit
    Wait Until Element Is Visible    ${pnPreview}    

#Edit Image keyword    
Redact Black
    Select Image Tool    Zoomfit
    Select Image Tool    RedactBlack
    Draw Rectangle At Coorfinates    ${pnPreview}    10    200
    Click Button    ${btnYes}
    Wait For Page
    
Redact White
    Select Image Tool    Zoomfit
    Select Image Tool    RedactWhite
    Draw Rectangle At Coorfinates    ${pnPreview}    10    200
    Click Button    ${btnYes}
    Wait For Page
    
Annotate
    [Arguments]    ${message}
    Select Image Tool    Zoomfit
    Wait For Page
    Select Image Tool    Annotate
    Draw Rectangle At Coorfinates    ${pnPreview}    10    200
    Input Text    ${txtAnnotate}    ${message}
    Press Key    ${txtAnnotate}    \\13
    Click Button    ${btnYes}
    Wait For Page
    
Zoom In And Verify
    Select Image Tool    Zoomfit
    Wait For Page
    @{before}=    Get Element Demention    ${pnPreview}
    Select Image Tool    Zoomin
    Wait For Page
    @{after}=    Get Element Demention    ${pnPreview}
    ${pass}=    Evaluate    @{before}[0] < @{after}[0] and @{before}[1] < @{after}[1]    
    Run Keyword If    not ${pass}    Fail    Zoom in does not work    
    
Zoom Out And Verify
    Select Image Tool    Zoomfit
    Wait For Page
    @{before}=    Get Element Demention    ${pnPreview}
    Select Image Tool    Zoomout
    Wait For Page
    @{after}=    Get Element Demention    ${pnPreview}
    ${pass}=    Evaluate    @{before}[0] > @{after}[0] and @{before}[1] > @{after}[1]    
    Run Keyword If    not ${pass}    Fail    Zoom out does not work 
    
Zoom Fit And Verify
    Select Image Tool    Zoomfit
    Wait For Page
    @{preview}=    Get Element Demention    ${pnPreview}
    @{page}=    Get Element Demention    ${pnPageView}
    ${pass}=    Evaluate    @{preview}[1] == @{page}[1]    
    Run Keyword If    not ${pass}    Fail    Zoom fit does not work 
    
Zoom Normal And Verify
    Select Image Tool    Zoomnormal
    Wait For Page
    @{before}=    Get Element Demention    ${pnPreview}
    Select Image Tool    Zoomfit
    Wait For Page
    @{after}=    Get Element Demention    ${pnPreview}
    ${pass}=    Evaluate    @{before}[0] != @{after}[0] and @{before}[1] != @{after}[1]    
    Run Keyword If    not ${pass}    Fail    Zoom normal does not work    
    
First Page
    Select Image Tool    First
    
Last Page
    Select Image Tool    Last
    
Next Page
    Select Image Tool    Next
    
Previous Page
    Select Image Tool    Previous
    
Rotate Left And Verify
    @{before}=    Get Element Demention    ${pnPreview}
    Select Image Tool    Rotate90
    Wait For Page
    @{after}=    Get Element Demention    ${pnPreview}
    ${pass}=    Evaluate    @{before}[0] == @{after}[1] and @{before}[1] == @{after}[0]    
    Run Keyword If    not ${pass}    Fail    Rotate left does not work  
    
Rotate Right And Verify
    @{before}=    Get Element Demention    ${pnPreview}
    Select Image Tool    Rotate270
    Wait For Page
    @{after}=    Get Element Demention    ${pnPreview}
    ${pass}=    Evaluate    @{before}[0] == @{after}[1] and @{before}[1] == @{after}[0]    
    Run Keyword If    not ${pass}    Fail    Rotate right does not work 

#Verify keyword    
Verify Redact Black
    Area Color Should Be   previewImage    black    10    200
    
Verify Redact White
    Area Color Should Be    previewImage    white    10    200

Verify Annotate
    Area Color Should Not Be    previewImage    white    10    200
    
Verify Current Page
    [Arguments]    ${pageno}    ${total}
    ${expect}=    Catenate    Current Page: 	${pageno}    of    ${total}
    SeleniumLibrary.Element Text Should Be    ${txtCurrentPage}    ${expect}   
    
    