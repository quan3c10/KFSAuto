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
   
sc1 = {
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

sc2 = {
        "Name":"AutoSC2",
        "destination":"Kofax Capture",
        "formtype":"SmokeTest2 Form Type"
    }

job1 = {
        "Name":"Job1.tif",
        "images":"DocNo0001.tif", 
        "shortcut":"AutoSC1"
    }

job2 = {
        "Name":"Job1.tif",
        "images":"DocNo0001.tif", 
        "shortcut":"PersonalSC1"
    }
    
scverify = {
        "Name":"AutoSC1",
        "general":{
            "Batch Field Char100":"My Batch Field Value",
            "Batch Field Small Int":'0',
            "Index Field 1 Alpha25":"Index1 Default",
            "Index Field 2 D10.2":"12345678.88"
        }
    }

psc1 = {
        "OldName":"AutoSC1",
        "Name":"PersonalSC1"
    }

psc1verify = {
        "OldName":"AutoSC1",
        "Name":"PersonalSC1",
        "general":{
            "Batch Field Char100":"My Batch Field Value",
            "Batch Field Small Int":'0',
            "Index Field 1 Alpha25":"Index1 Default",
            "Index Field 2 D10.2":"12345678.88"
        }
    }

psc2 = {
        "OldName":"PersonalSC1",
        "Name":"PersonalSC1",
        "general":{
            "Batch Field Char100":"Personal Batch",
            "Batch Field Small Int":'123',
            "Index Field 1 Alpha25":"Personal Index",
            "Index Field 2 D10.2":"11111111.11"
        }
    }

coversheet = {
        "Name":"AutoSC1",
        "general":{
            "Batch Field Char100":"My Batch Field Value",
            "Batch Field Small Int":'0',
            "Index Field 1 Alpha25":"Index1 Default",
            "Index Field 2 D10.2":"12345678.88"
        }
    }
    
psc1edit = {
        "OldName":"PersonalSC1",
        "Name":"MySC1"
    }

batch1 = {
        "Name":"My Batch Field Value",
        "page":2,
        "fields":{
            "BF2 SmallInt":0,
            "Index1 Alpha25":"Index1 Default"
        }
    }

batch2 = {
        "Name":"Personal Batch",
        "page":2,
        "fields":{
            "BF2 SmallInt":123,
            "Index1 Alpha25":"Personal Index"
        }
    }