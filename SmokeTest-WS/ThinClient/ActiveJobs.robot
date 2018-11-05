*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
Library    CustomSeleniumLibrary       
Library    OperatingSystem    
*** Keyword ***
#Function keywords
Send Job by Shortcut
    [Arguments]    ${job}
    ${jobID}=    Import Job    ${job}
    &{activejob}=    Get Job By ID    ${jobID} 
    ${button}=    Set Variable    ${activejob.Button}
    ${fields}=    Get Button Fields    ${activejob.DestinationName}
    Run Keyword If    'Fields' in ${job}    Set Fields Values    ${fields}    &{job}[Fields] 
    ${body}=    Create Dictionary    Button=${button}    Fields=${fields}    TransactionUniqueID=${jobID}
    &{res}=    Post    ${KDEPage}submit//    body=${body}
    Check Response    ${res}     
    Verify Job Submission    ${jobID}    
Import Job
    [Arguments]    ${job}    ${transactionID}=    ${filename}=
    Run Keyword If    '${filename}' is ''    Delete All Active Jobs
    &{button}=     Get Button    &{job}[Destination]         
    ${file}=    Set Variable If    '${filename}' is not ''    ${filename}    &{job}[FileName]  
    ${data}=    Create Dictionary    transactionID=${transactionID}    buttonID=${button.ButtonID}    buttonContext=${button.ButtonContext}    sessionID=${sessionID}    
    ${jobid}=    Upload Image    ${KDEPage}document/upload/    ${file}    ${data}
    [Return]    ${jobid}
    
Import Multiple Pages Job
    [Arguments]    ${job}    ${transactionID}=""    ${filename}=""
    Delete All Active Jobs
    &{button}=     Get Button    ${job.Destination}
    Run Keyword If    ${filename}!=""    Log To Console    Empty  
    ...    ELSE    Log To Console    has value          
    @{file}=    Set Variable If    ${filename}!=""    ${filename}    ${job.FileName}  
    ${data}=    Create Dictionary    transactionID=${transactionID}    buttonID=${button.ButtonID}    buttonContext=${button.ButtonContext}    sessionID=${sessionID}    
    ${jobid}=    Upload Multiple Images    ${KDEPage}document/upload/    ${file}    ${data}
    [Return]    ${jobid}
Add Image To Job
    [Arguments]    ${job}    ${filename}
    &{activejob}=    Get Job By Name    &{job}[Name]
    ${tranID}=    Set Variable    ${activejob.ID}
    Import Job    ${job}    ${tranID}    ${filename}  
Delete Image From Job
    [Arguments]    ${job}    ${pageno}
    ${id}=    Get Page ID    ${job}    ${pageno}
    ${url}=    Catenate    SEPARATOR=    ${KDEPage}document/page/    ${id}//
    &{res}=    Delete    ${url}
    Check Response    ${res}              
Delete All Active Jobs
    ${jobs}=     Get All Jobs
    ${body}=    Create List    
    :FOR    ${job}    IN    @{jobs}
    \    Append To List    ${body}    ${job.ID}
    &{res}=    Post    ${KDEPage}transactions/deleteselected//    body=${body}
    Check Response    ${res}
Rename Job
    [Arguments]    ${jobid}    ${name}
    ${body}=    Create Dictionary    DocumentID=${jobid}    Name=${name}  
    &{res}=    Post    ${KDEPage}document/setdocumentattributes//    body=${body}  
    Check Response    ${res}  
Merge Jobs
    [Arguments]    ${first}    @{jobs}
    &{job1}=    Get Job By Name    &{first}[Name]
    ${id1}=    Set Variable    ${job1.ID}
    @{ids}=    Create Dictionary    
    :FOR    ${job}    IN    @{jobs}
    \    &{reljob}=    Get Job By Name    &{job}[Name]
    \    Append To List    ${ids}    ${reljob.ID}           
    ${body}=    Create Dictionary    TargetTransactionId=${id1}    SourceTransactionIds=${ids}
    &{res}=    Put    ${KDEPage}document/merge//    body=${body}
    Check Response    ${res}
Download Document
    [Arguments]    ${job}    ${file_name}
    &{activejob}=    Get Job By Name    &{job}[Name]
    ${url}=    Catenate    SEPARATOR=    ${KDEPage}document/download?transactionid=    ${activejob.ID}    
    ${path}=    Download Image    ${url}    ${file_name}    ${sessionid}
    Run Keyword And Return    File Should Exist    ${path}    
Split Job
    [Arguments]    ${job}    @{pagesno}
    ${oldjob}=    Get Job By Name    &{job}[Name]
    ${allpages}=    Get Pages ID   ${job}
    ${split_pages}=    Create List    
    :FOR    ${no}    IN    @{pagesno}
    \    ${id}=    Get Page ID    ${job}    ${no}    
    \    Append To List    ${split_pages}    ${id}
    ${button}=    Get Button    &{job}[Destination]
    ${body}=    Create Dictionary    Button=${button}    SelectedPages=${split_pages}
    &{res}=    Post    ${KDEPage}document/page/split//    body=${body}
    Check Response    ${res} 
    :FOR    ${page}    IN    @{split_pages}
    \    Remove Values From List    ${allpages}    ${page}   
    Verify Splits Job    &{oldjob}[ID]    ${allpages}    ${split_pages}           
    
#Get job information keywords
Get Job By ID
    [Arguments]    ${id}
    ${jobs}=    Get All Jobs 
    :FOR    ${job}    IN    @{jobs}        
    \    ${return}=    Run Keyword If    '${job.ID}'=='${id}'    Convert To Dictionary    ${job}
    \    Exit For Loop If    ${return}!=None
    Run Keyword If    ${return}==None    Fail    The job with id "${id}" does not exists.        
    [Return]    ${return} 
Get Job By Name
    [Arguments]    ${name}
    ${jobs}=    Get All Jobs 
    :FOR    ${job}    IN    @{jobs}  
    \    ${expect}=    Run Keyword And Return Status   Should Contain    ${job.Name}    ${name}          
    \    ${return}=    Run Keyword If    ${expect}    Convert To Dictionary    ${job}
    \    Exit For Loop If    ${return}!=None
    Run Keyword If    ${return}==None    Fail    The job with name "${name}" does not exists.        
    [Return]    ${return}
Get All Jobs
    &{res}=    Get    ${KDEPage}transactions//
    Check Response    ${res}
    [Return]    ${res.body['Transactions']}  
#Scan History records
Get Transaction By ID
    [Arguments]    ${id}
    ${trans}=    Get All Transactions
    :FOR    ${tran}    IN    @{trans}
    \    Return From Keyword If    '&{tran}[ID]'=='${id}'    ${tran}
    Return From Keyword    ${None}
Get All Transactions
    &{res}=    Get    ${KDEPage}transactions/history
    Check Response    ${res}
    [Return]    ${res.body['JobHistory']}    
#Pages
Get Pages By Name
    [Arguments]    ${name}       
    &{activejob}=    Get Job By Name    ${name}
    ${url}=    Catenate    SEPARATOR=    ${KDEPage}transactions?transactionid=    ${activejob.ID}
    &{res}=    Get    ${url}
    Check Response    ${res}
    &{body}=    Set Variable    ${res.body}    
    [Return]    ${body.Documents[0]['Pages']}
Get Pages By ID
    [Arguments]    ${id}
    &{activejob}=	Get Job By ID    ${id}
    ${url}=    Catenate    SEPARATOR=    ${KDEPage}transactions?transactionid=    ${activejob.ID}
    &{res}=    Get    ${url}
    Check Response    ${res}
    &{body}=    Set Variable    ${res.body}    
    [Return]    ${body.Documents[0]['Pages']}            
Get Page ID
    [Arguments]    ${job}    ${pageno}
    ${pages}=    Get Pages By Name    &{job}[Name]
    ${index}=    Evaluate    ${pageno}-1    
    &{page}=    Set Variable    @{pages}[${index}]
    [Return]    ${page.ID}           
Get Pages ID
    [Arguments]    ${job}
    ${pages}=    Get Pages By Name    &{job}[Name]
    ${ids}=    Create List    
    :FOR    ${page}    IN    @{pages}    
    \    Append To List    ${ids}    &{page}[ID]  
    [Return]    ${ids}
     
#Verify keywords
Verify Job Submission
    [Arguments]    ${transactionID}    ${timeout}=0
	${timeout}=    Set Variable If    ${timeout}!=0    ${timeout}    60     
    :FOR    ${count}    IN RANGE    ${timeout}
    \    &{tran}=    Get Transaction By ID    ${transactionID}
    \    Run Keyword If    ${tran} is ${None}    Fail    Cannot find job with ID "${transactionID}"        
    \    Return From Keyword If    '${tran.Status}'=='Completed'    True
    \    Sleep    1s    
    Fail    Job with ID "${transactionID}" is not submitted after ${timeout} seconds with status "${tran.Status}" 
Verify Job Exists
    [Arguments]    ${job}    ${exists}=True   
    ${actual}=    Run Keyword And Return Status    Get Job By Name    &{job}[Name]
    Should Be Equal    '${actual}'    '${exists}'    Expect job "&{job}[Name]" exists equal ${exists} but ${actual}    
Verify Page Count
    [Arguments]    ${job}    ${expect}   
    &{activejob}=    Get Job By Name    &{job}[Name]
    ${actual}=    Set Variable    ${activejob.Documents[0]['PageCount']}    
    Should Be Equal    '${actual}'    '${expect}'    Expect job "&{job}[Name]" has ${expect} pages but it has ${actual} pages. 
Verify Splits Job
    [Arguments]    ${oldjob}    ${old_pages}    ${split_pages}
    ${alljobs}=    Get All Jobs
    @{jobs}=    Create List    
    :FOR    ${job}    IN    @{alljobs}
    \    Append To List    ${jobs}    ${job.ID}    
    Remove Values From List    ${jobs}    ${oldjob} 
    Job Should Has Pages    ${oldjob}    ${old_pages}
    Job Should Has Pages    @{jobs}[0]    ${split_pages}    
Job Should Has Pages
    [Arguments]    ${id}    ${expects}
    @{pages}=    Get Pages By ID    ${id}
    ${actuals}=    Create List      
    :FOR    ${page}    IN    @{pages}
    \    Append To List    ${actuals}    ${page.ID}        
    Lists Should Be Equal    ${actuals}    ${expects}    Actual pages ${actuals} but expect ${expects}                                     