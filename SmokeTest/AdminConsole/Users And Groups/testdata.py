"""
Sample test data

The key's name in upper case should not change
The key's name in lower case is able to change

The key "OldName" is use for Edit only (this is the name of object before edit).
The key "ID" is use instead of key "OldName" when edit User.

variable = {
        "ID":"",
        "OldName":"",
        "Name":"",
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

permission = {
        "Name":"AutoPermission1",
        "activities":{
            "Associated":["View Document"]
        }
    }
shortcut = {
        "Name":"AutoSC01",
        "destination":"Kofax Capture"
    }
KCAuto01 = {
        "ID":"KCAuto01",
        "Name":"KC Auto 01",
        "general":{
            "Description":"KC Automated Test User 01"
        },    
        "members":{
            "Available":["Group2"],
            "Associated":["(Everyone)","Group1"]
        },    
        "permissions":{
            "Available":["Default Permissions"],
            "Associated":["AutoPermission1"]
        }
    }
editKCAuto01 = {
        "ID":"KCAuto01",
        "Name":"KC Auto 01",
        "general":{
            "Description":"KC Automated Test User 01"
        },    
        "members":{
            "Available":["Group2"],
            "Associated":["(Everyone)","Group1"]
        },    
        "permissions":{
            "Available":["Default Permissions","AutoPermission1"],
            "Associated":[]
        }
    }
GroupTest1 = {
        "OldName":"Group1",
        "Name":"Group1",  
        "members":{
            "Available":["KCAuto02","KCAuto03"],
            "Associated":["KCAuto01"]
        },    
        "permissions":{
            "Available":["Default Permissions","AutoPermission1"],
            "Associated":[]
        },    
        "shortcuts":{
            "Available":["AutoSC01"],
            "Associated":[]
        }
    }
editGroup1 = {
        "OldName":"Group1",
        "Name":"Group1",  
        "members":{
            "Available":["KCAuto02","KCAuto03"],
            "Associated":["KCAuto01"]
        },    
        "permissions":{
            "Available":["Default Permissions"],
            "Associated":["AutoPermission1"]
        },    
        "shortcuts":{
            "Available":[],
            "Associated":["AutoSC01"]
        }
    }