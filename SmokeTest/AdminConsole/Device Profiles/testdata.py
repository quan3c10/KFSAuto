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

device1 = {
        "Name":"AutoDevice1",
        "general":{
            "IP":"11.11.11.11",
            "Device Name":"AutoDevice1",
            "Host Name":"AutoHost1",
            "Model":"Lexmark x646e",
            "MAC Address":"12-34-56-78-90-AA"
        }
    }
device2 = {
        "Name":"AutoDevice2",
        "general":{
            "IP":"11.11.11.12",
            "Device Name":"AutoDevice2",
            "Host Name":"AutoHost2",
            "Model":"Lexmark x646e",
            "MAC Address":"12-34-56-78-90-AB"
        }    
    }
sc1 = {
        "Name":"AutoSC1",
        "destination":"Kofax Capture",
        "form type":"SmokeTest2 Form Type"
    }
sc2 = {
        "Name":"AutoSC2",
        "destination":"Kofax Capture",
        "form type":"SmokeTest2 Form Type"
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
        "devices":{
            "Associated":["AutoDevice1","AutoDevice2"]
        }
    }
asshortcut = {
        "OldName":"AutoProfile1",
        "Name":"AutoProfile1",
        "shortcuts":{
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