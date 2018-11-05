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

device = {
        "Name":"MyDevice",
        "general":{
            "IP":"10.20.30.40",
            "Device Name":"MyDevice",
            "Host Name":"MyHost",
            "Model":"Lexmark xxxxx",
            "MAC Address":"01-02-03-04-05-06"
        }
    }
dvedit = {
        "OldName":"MyDevice",
        "Name":"MyDeviceModded",
        "general":{
            "IP":"11.22.33.44",
            "Device Name":"MyDeviceModded",
            "Host Name":"MyHostModded",
            "Model":"Lexmark yyyy",
            "MAC Address":"01-02-03-04-05-06"
        }    
    }