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

profile1 = {
        "Name":"Prof1",
        "general":{
            "Description":"Prof1 Desc",
            "Logon":True,
            "Default":True
        }
    }
    
profile2 = {
        "Name":"Prof2",
        "general":{
            "Description":"Prof2 Desc",
            "Logon":True,
            "Default":False
        }
    }
    
profile3 = {
        "Name":"Prof3",
        "general":{
            "Description":"Prof3 Desc",
            "Logon":True,
            "Default":False
        }
    }
    
sc = {
        "Name":"AutoSC",
        "destination":"MyAutoKCDest",
        "formtype":"SmokeTest2 Form Type"
    }
    
des = {
        "Name":"MyAutoKCDest",
        "general":{
            "Destination Type":{"Select":"Kofax Capture"}
        }
    }
    
scverify = {
        "Name":"AutoSC",
        "general":{
            "Form Type":{"Select":"SmokeTest2 Form Type"},
            "Batch Field Char100":"",
            "Batch Field Small Int":'0',
            "Index Field 1 Alpha25":"Index1 Default",
            "Index Field 2 D10.2":"12345678.88"
        },
        "scan":{
            "DPI":{"Select":"200"},
            "Color Mode":{"Select":"Black and White"},
            "Maximize":False,
            "Deskew":False,
            "Crop":False,
            "Blank":False,
            "Rotation":False,
            "Inherit":False
        },
        "groups":{
            "Associated":[],
            "Available":["(Everyone)","Group1","Group2"]
        },
        "profiles":{
            "Associated":[],
            "Available":["Prof1","Prof2","Prof3"]
        }
    }
    
scedit = {
        "OldName":"AutoSC",
        "Name":"AutoSC",
        "general":{
            "Form Type":{"Select":"SmokeTest2 Form Type"},
            "Batch Field Char100":{
                "Value":"Batch Field Modified",
                "Visible":{"Masked":False,"Thin Client":True,"MFP":False,"Mobile":False,"Summary":False}
            },
            "Batch Field Small Int":{
                "Value":"123",
                "Visible":{"Masked":False,"Thin Client":False,"MFP":False,"Mobile":False,"Summary":False}
            },
            "Index Field 1 Alpha25":{
                "Value":"Index1 Modified",
                "Visible":{"Masked":False,"Thin Client":True,"MFP":False,"Mobile":False,"Summary":False}
            },
            "Index Field 2 D10.2":{
                "Value":"98765432.11",
                "Visible":{"Masked":False,"Thin Client":False,"MFP":False,"Mobile":False,"Summary":False}
            }
        },
        "scan":{
            "DPI":{"Select":"400"},
            "Color Mode":{"Select":"Color"},
            "Maximize":True,
            "Deskew":True,
            "Crop":True,
            "Blank":True,
            "Rotation":True
        },
        "groups":{
            "Associated":["Group1"],
            "Available":["(Everyone)","Group2"]
        },
        "profiles":{
            "Associated":["Prof1","Prof3"],
            "Available":["Prof2"]
        }
    }