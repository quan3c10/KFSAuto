import json

variables = {}

def get_variables(path):
    with open(path,'r') as datafile:
        data = json.load(datafile)
        for key in data.keys():
            variables.update({key:data[key]})
    return variables
