"""
Sample test data

The key's name in upper case should not change
The key's name in lower case is able to change

The key "OldName" is use for Edit only (this is the name of object before edit).
The key "ID" is use instead of key "OldName" when edit User.

variable = {
        "ID":"",
        "Name":"",
        "NewName":"",
        "tab name":{
            "field":"value",
            "checkbox":true,
            "field":{
                "Select":"value",
                "Value":"value",
                "Visible":{"checkbox":true}
            }
            "Associated":["option"],
            "Available":["option"]
        }    
    }
"""
   
sc = {
        "Name":"Validation Script",
        "destination":"Kofax Capture",
        "formtype":"Test Script KC10",
        "groups":{
            "Associated":["Group1"],
            "Available":["(Everyone)","Group2"]
        }
    }
    
job = {
        "Name":"Job1.tif",
        "images":"DocNo0001.tif", 
        "shortcut":"Validation Script",
        "validation":{
            "1st":{
                "Input":{
                    "Name":"KFS User",
                    "Disabled":True
                },
                "Dropdown":{
                    "Name":"Country",
                    "Selections":["USA","Austria","Germany","Vatican"],
                    "Select":"Austria",
                    "Event":True
                }
            },
            "2nd":{
                "Dropdown":{
                    "Name":"City",
                    "Selections":["Vienna","Salzburg","Linz","Innsbruck"],
                    "Select":"Vienna",
                    "Event":False
                }
            },
            "3nd":{
                "Input":{
                    "Name":"User ID",
                    "Fill":"0001",
                    "Event":True
                }
            }
        }
    }

auth = {
        "UserID":"KCAuto01",
        "Password":"k00fax",
        "encryptedPassword":"98LWAXqgwkc="
    }
admin = {
        "UserID":"admin",
        "Password":"k00fax",
        "encryptedPassword":"98LWAXqgwkc="
    }

device={
        "IPAddress":"11.11.11.11",
        "DeviceName":"11Device",
        "HostName":"11Host",
        "Model":"11Model",
        "MacAddress":"111111111111"
    }

device1={
        "IPAddress":"22.22.22.22",
        "DeviceName":"22Device",
        "HostName":"22Host",
        "Model":"22Model",
        "MacAddress":"222222222222"
    }

profile={
        "Name":"MyProf",
        "Description":"MyProf Description",
        "AllowLogon":True,
        "IsDefault":False
    }

profile1={
        "Name":"MyProf1",
        "Description":"MyProf Description",
        "AllowLogon":True,
        "IsDefault":False
    }

des = {
        "Name":"MyKCDest1",
        "AuthUser":"",
        "AuthPassword":"",
        "Destination Type":"Kofax Capture",
        "Description":"MyKCDest1 Description",
        "Fields":{"Batch Priority":"4"},
        "Groups":{
            "Associated":["Group1"],
            "Available":["(Everyone)","Group2"]
        },
        "Profiles":{
            "Associated":["MyProf"],
            "Available":["Default Profile"]
        }
    }
emaildes = {
        "Name":"MyEmailDest1",
        "AuthUser":"sqakfs@gmail.com",
        "AuthPassword":"K00fax12",
        "Destination Type":"Email",
        "Description":"My email destination",
        "Fields":{
            "Server Type":"SMTP",
            "Host":"smtp.gmail.com",
            "Port":"587"
            },
        "Groups":{
            "Associated":["Group1"],
            "Available":["(Everyone)","Group2"]
        },
        "Profiles":{
            "Associated":["MyProf"],
            "Available":["Default Profile"]
        }
    }
sc = {
        "Name":"EmailPSC",
        "Destination":"Email_SC",
        "Description":"My personal shortcut description",
        "Fields":{
            "To":"quanhong.ung@kofax.com",
            "Subject":"PSC"
            }
    }
job = {
        "Name":"DocNo0001.tif",
        "Destination":"GroupSC",
        "FileName":"DocNo0001.tif"
    }
job1 = {
        "Destination":"GroupSC",
        "FileName":["Img001.jpg","Img002.jpg"],
        "Fields":{
            "File Name":"legacy_ws"
            }
    }
job2 = {
        "Name":"Img002.jpg",
        "Destination":"GroupSC",
        "FileName":["Img002.jpg"]
    }

validation_job ={
        "Destination":"GroupSC",
        "FileName":["Img001.jpg","Img002.jpg"],
        "Fields":{
            "File Name":"legacy_ws"
            },
        "Validation":True
    }
