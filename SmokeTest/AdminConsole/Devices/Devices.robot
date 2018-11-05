*** Setting ***
Resource    ../AdminFunctions.robot

*** Variable ***
#General tab
${txtIP}    id:edit-device-IPAddress
${txtMAC}    id:edit-device-MacAddress
${txtHost}    id:edit-device-HostName
${txtDevice}    id:edit-device-DeviceName
${txtVendor}    id:edit-device-Vendor
${txtModel}    id:edit-device-Model
${drProfile}    id:edit-device-Profile

*** Keyword ***
Create Device
    [Arguments]    ${cleanup}=False    &{device}
    BuiltIn.Run Keyword If    ${cleanup}    Clean Up    
    Select Button    Create  
    BuiltIn.Run Keyword If    'general' in &{device}    Devices.Fill General    &{device}[general]    
    Select Button    Save 
Edit Device
    [Arguments]    &{device}
    Edit    ${device.OldName}
    BuiltIn.Run Keyword If    'general' in &{device}    Devices.Fill General    &{device}[general]     
    Select Button    Save 
Device Should Be Update
    [Arguments]    &{device}
    Edit    ${device.Name}
    AdminFunctions.Verify Text Value    Device    ${device.Name}   
    BuiltIn.Run Keyword If    'general' in &{device}    Devices.Verify General    &{device}[general]   
    Select Button    Cancel 
Device Should Be Remove
    [Arguments]    &{device}
    AdminFunctions.Delete    ${device.Name}

#Fill value keywords
Fill General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Set Fields Value    ${name}    &{fields}[${name}]   

#Verify keywords
Verify General
    [Arguments]    ${fields}
    @{names}=    Collections.Get Dictionary Keys    ${fields}
    :FOR    ${name}    IN    @{names}
    \    AdminFunctions.Verify Fields Value    ${name}    &{fields}[${name}]    