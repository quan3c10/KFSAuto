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
   
des = {
        "Name":"MyKCDest1",
        "AuthUser":"",
        "AuthPassword":"",
        "Destination Type":"Kofax Capture",
        "Description":"MyKCDest1 Description",
        "Fields":[
            {"Test Script KC10":""}
        ],
        "Groups":{
            "Associated":["Group1"],
            "Available":["(Everyone)","Group2"]
        },
        "Profiles":{
            "Associated":["MyProf"],
            "Available":["Default Profile"]
        }
    }
    