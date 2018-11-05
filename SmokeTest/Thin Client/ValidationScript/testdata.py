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

batch = {
        "Name":"Austria",
        "page":2,
        "fields":{
            "Country":"Austria",
            "City":"Vienna",
            "Result":"Ben Yim would like to visit Vienna, Austria some day  to learn KFS Web Client"
        }
    }

