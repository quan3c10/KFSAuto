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
        "general":{
            "Description":"Permission 1 for automated test."
        }
    }
default = {
        "Name":"Default Permissions",
        "general":{
            "Description":"Default Permissions"
        },    
        "users":{
        "Available":["Admin","KCAuto01","KCAuto02","KCAuto03"]
        },    
        "groups":{
        "Available":["Group1","Group2"],
        "Associated":["(Everyone)"]
        },    
        "activities":{
        "Associated":[
            "Add Page",
            "Change Scanner Settings for Thin Client Scanning",
            "Delete Document",
            "Delete Page",
            "Document Note",
            "Image Annotation",
            "Merge Document",
            "Redact with Black",
            "Redact with White",
            "Rename Document",
            "Reorder Page",
            "Rotate Page",
            "Save Document",
            "Split Document",
            "Thin Client Scanning",
            "Upload Document",
            "View Document",
            "View eDocument"]
        }
    }
vepermission = {
        "Name":"AutoPermission1",
        "general":{
            "Description":"Permission 1 for automated test."
        },    
        "users":{
            "Available":["Admin","KCAuto01","KCAuto02","KCAuto03"]
        },    
        "groups":{
            "Available":["(Everyone)","Group1","Group2"]
        },    
        "activities":{
            "Available":[
                "Add Page",
                "Change Scanner Settings for Thin Client Scanning",
                "Delete Document",
                "Delete Page",
                "Document Note",
                "Image Annotation",
                "Merge Document",
                "Redact with Black",
                "Redact with White",
                "Rename Document",
                "Reorder Page",
                "Rotate Page",
                "Save Document",
                "Split Document",
                "Thin Client Scanning",
                "Upload Document",
                "View Document",
                "View eDocument"]
        }
    }
associate = {
        "OldName":"AutoPermission1",
        "Name":"AutoPermission1",  
        "general":{
            "Description":"Permission 1 for automated test."
        },   
        "users":{
            "Available":["Admin","KCAuto03"],
            "Associated":["KCAuto01","KCAuto02"]
        },    
        "groups":{
            "Available":["(Everyone)"],
            "Associated":["Group1","Group2"]
        },    
        "activities":{
            "Associated":["Delete Document","Merge Document","Upload Document","Save Document"],
            "Available":[
                "Add Page",
                "Change Scanner Settings for Thin Client Scanning",
                "Delete Page",
                "Document Note",
                "Image Annotation",
                "Redact with Black",
                "Redact with White",
                "Rename Document",
                "Reorder Page",
                "Rotate Page",
                "Split Document",
                "Thin Client Scanning",
                "View Document",
                "View eDocument"]
        }
    }
profile = {
        "Name":"AutoProfile1",
        "general":{
            "Description":"Device profile for automated test.",
            "Logon":False,
            "Default":False
        }
    }
assdevice = {
        "OldName":"AutoProfile1",
        "Name":"AutoProfile1",
        "device":{
            "Associated":["AutoDevice1","AutoDevice2"]
        }
    }
asshortcut = {
        "OldName":"AutoProfile1",
        "Name":"AutoProfile1",
        "shortcut":{
            "Associated":["AutoSC1","AutoSC2"]
        }
    }

editprofile = {
        "OldName":"AutoProfile1",
        "Name":"AutoProfile1Mod",
        "general":{
            "Description":"Device profile for automated test - modified.",
            "Logon":True,
            "Default":True
        }
    }