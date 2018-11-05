'''
Created on Jul 13, 2018

@author: sqaadmin
'''
from zeep import Client
import os,socket,requests
from pathlib import  Path
from Legacy_WS import LegacyWebService as ws
from GetConfigures import GetConfigures as cf

def upload_images(url,file_names,_data):
        """
        This keyword use to download Kofax WebCapture from thinclient and save to disk as file_name.
        The path to downloaded file will be returned.
        
        ``url`` (str) : webservice url.
        
        ``file_names`` (arr): array contains all files name.
        
        ``data`` (dict): the dictionary contains transactionID, buttonID, buttonContext, sessionID 
        """
        _cookie = {"KFS_AUTH_THINCLIENT":_data['sessionID']}
        
        file = os.path.join("C:\OneDrive\Documents\Automation\KFS-Robot\SmokeTest-WS\TestResource\Documents",file_names)
        _files = {"Filedata":open(file,'rb')}
        
        _upload = requests.post(url,cookies=_cookie, data=_data,files=_files,stream=True)
        _body = _upload.json()
        print(_body['ErrorCode'])
        if _upload.status_code != 200: 
            raise AssertionError("Fail to upload images with code: {0},error: {1}".format(_upload.status_code, _upload.content)) 
        
def download_image(url,file_name,_sessionID):
        """
        This keyword use to download image from job and save as the given file name
        
        ``url`` (str) : webservice url.
        
        ``file_names`` (str): files name.
        """
        _cookie = {"KFS_AUTH_THINCLIENT":_sessionID}
        
        _file = os.path.join(Path.home(),"Downloads",file_name)
        
        _download = requests.get(url,cookies=_cookie,stream=True)
        _body = _download.json()
        print(_body['ErrorCode'])
        if _download.status_code != 200: 
            raise AssertionError("Fail to upload images with code: {0},error: {1}".format(_download.status_code, _download.content)) 
        with open(_file, 'wb') as f:
            f.write(_download.content)
        return _file
            
def remove_values_from_list(list_, *values):
        """Removes all occurrences of given ``values`` from ``list``.

        It is not an error if a value does not exist in the list at all.

        Example:
        | Remove Values From List | ${L4} | a | c | e | f |
        =>
        | ${L4} = ['b', 'd']
        """
        for value in values:
            while value in list_:
                list_.remove(value)
            
if __name__ == '__main__':
    job = {
        "Destination":"GroupSC",
        "FileName":["Img001.jpg","Img002.jpg"],
        "Fields":{
            "File Name":"quan"
            }
    }
    ws = ws()
    cf = cf()
    job1 = ws.ping_server()
    print(job1)