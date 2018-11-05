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

edoc = {
        "Name":"DESPortalUploadTest.doc",
        "images":"DESPortalUploadTest.doc"
    }
job1 = {
        "Name":"DESPortalUploadTest.tif",
        "images":"DESPortalUploadTest.tif" 
    }
job2 = {
        "Name":"DocNo0001.tif",
        "images":"DocNo0001.tif" 
    }