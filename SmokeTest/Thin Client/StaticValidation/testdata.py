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
        "Name":"AutoSC1",
        "destination":"Kofax Capture",
        "formtype":"SmokeTest2 Form Type",
        "general":{
            "Batch Field Char100":"My Batch Field Value"
        },
        "groups":{
            "Associated":["Group1"],
            "Available":["(Everyone)","Group2"]
        }
    }
    
job = {
        "Name":"Job1.tif",
        "images":"DocNo0001.tif", 
        "shortcut":"AutoSC1",
        "validation":{
            "1st":{
                "Input":{
                    "Batch Field Small Int":"asdf"
                },
                "Verify":{
                    "Batch Field Small Int":"The value of this index field must be an integer."
                }
            },
            "2nd":{
                "Input":{
                    "Batch Field Small Int":"123",
                    "Index Field 1 Alpha25":""
                },
                "Verify":{
                    "Batch Field Small Int":"",
                    "Index Field 1 Alpha25":"Index Field 1 Alpha25 is a required field and it must have a value."
                }
            }
        }
    }

