'''
Created on Jul 17, 2018

@author: sqaadmin
'''
from SeleniumLibrary import SeleniumLibrary
from selenium.webdriver import ActionChains
import time, unittest,os,requests,re
from pathlib import Path
from CustomSeleniumLibrary import CustomSeleniumLibrary
from selenium.webdriver.common.keys import Keys
from io import BytesIO
from PIL import Image
import base64
from base64 import decodestring

class CustomLib():
    
    def __init__(self):
        self.sl = SeleniumLibrary()
        
        
class TestCustomLibrary(unittest.TestCase):
    
    def test_redact_black(self):
        sl =  SeleniumLibrary()
        sl.open_browser("http://172.26.1.60/Kofax/KFS/ThinClient/login.html","ie");
        sl._current_browser().maximize_window()
        sl.input_text("id:userid","kcauto01")
        sl.input_password("id:password","k00fax")
        sl.click_button("id:submitspan")
        time.sleep(1)
        sl.click_link("id:menu-new-doc")
        time.sleep(1)
        sl.click_link("//div[contains(text(),'Kofax Capture')]//ancestor::a[1]")
        time.sleep(3)
        sl.click_link("id:btn-scan-setting")
        time.sleep(1)
        sl.click_link("id:linkDownloadFile")
        action = ActionChains(self.lib.driver)
        action.key_down(getattr(Keys, 'ALT')).send_keys()
        sl.close_browser()
        
        
if __name__ == '__main__':
#     file_name = "C:\\Users\\sqaadmin\\Downloads\\Kofax.WebCapture.Installer.msi"
#     _json = {"UserID":"admin","Password":""}
#     _login = requests.put("http://172.26.1.144/kofax/kfs/thinclient/auth/",json=_json)
#     _sessionID = _login.json()['SessionID']
#     _cookie = {"KFS_AUTH_THINCLIENT":_sessionID}
#     _download = requests.get("http://172.26.1.144/kofax/kfs/thinclient/DownloadWebCaptureServiceInstaller/",cookies=_cookie,stream=True)
#     with open(file_name, 'wb') as fd:
#         for chunk in _download.iter_content(chunk_size=128):
#             fd.write(chunk)
#         fd.close()
#     url = "http://172.26.1.60/kofax/kfs/thinclient"
#     file_name = "Kofax.WebCapture.Installer.msi"
#     file_name = os.path.join(Path.home(),"Downloads",file_name)
#     _json = {"UserID":"admin","Password":"k00fax"}
#     _login = requests.put(url + "/auth/",json=_json)
#     _sessionID = _login.json()['SessionID']
#     _cookie = {"KFS_AUTH_THINCLIENT":_sessionID}
#     _download = requests.get(url + "/DownloadWebCaptureServiceInstaller/",cookies=_cookie,stream=True)
#     if _download.status_code == 200:
#         with open(file_name, 'wb') as fd:
#             for chunk in _download.iter_content(chunk_size=128):
#                 fd.write(chunk)
#         print(re.sub(r'\\', r'\\\\', file_name))
    file = "C:\OneDrive\Documents\Automation\KFS-Robot\SmokeTest-WS\TestResource\Documents\Img001.jpg"
#     _img = Image.open(file)
#     _data = _img.tobytes()
#     imagefile = BytesIO(decodestring(_data))
#     #_img.save(imagefile, format='JPEG')
#     print(imagefile.getvalue())
    with open(file, "rb", buffering=0) as fh:
        f = fh.read()
        print(fh)