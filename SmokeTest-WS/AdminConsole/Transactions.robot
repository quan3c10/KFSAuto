*** Setting ***
Resource    ../TestResource/CommonFunctions.robot
Resource    Profiles.robot
Resource    Destinations.robot
*** Keyword ***
Get All Transactions   
    &{res}=    Get    ${KACPage}TransactionReviewService//?queued=true
    Check Response    ${res}
    [Return]    ${res.body['AdminObjects']}
    
Get Transaction By ID
    [Arguments]    ${id}
    ${transactions}=    Get All Transactions 
    :FOR    ${tran}    IN     @{transactions}
    \    Return From Keyword If    '&{tran}[TransactionID]'=='${id}'    ${tran}
    Return From Keyword    ${None} 
    
      
                              