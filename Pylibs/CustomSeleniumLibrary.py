from robot.libraries.BuiltIn import BuiltIn
from robot.libraries.BuiltIn import RobotNotRunningError
from robot.api.deco import keyword
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ActionChains
import os,requests
from pathlib import Path

class CustomSeleniumLibrary(object):
    ROBOT_LIBRARY_VERSION = '0.1'
    def __init__(self):
        self.get_lib
    
    def get_keyword_names(self):
        return [name for name in dir(self) if hasattr(getattr(self, name), 'robot_name')]  
    
    @property
    def get_lib(self):
        try:
            self.lib = BuiltIn().get_library_instance('SeleniumLibrary')
        except RobotNotRunningError:
            self.lib = None
        
    @keyword  
    def high_light(self,locator):
        """
        This keyword use to highlight the web element(defined by locator parameter) in the webpage.
        
        ``locator`` (WebElement locator) : the locator to identify the element.
        """
        element = self.selenium.find_element(locator)
        self.lib.driver.execute_script("arguments[0].style.border='3px solid red'", element)
        
    @keyword  
    def upload_image(self,url,file_name,_data):
        """
        This keyword use to upload file to create job.
        The job ID will be returned.
        
        ``url`` (str) : webservice url.
        
        ``file_names`` (str): files name.
        
        ``data`` (dict): the dictionary contains transactionID, buttonID, buttonContext, sessionID 
        """
        _cookie = {"KFS_AUTH_THINCLIENT":_data['sessionID']}
        
        file = os.path.join(os.getcwd(),"SmokeTest-WS","TestResource","Documents",file_name)
        _files = {"Filedata":open(file,'rb')}
        
        _upload = requests.post(url,cookies=_cookie, data=_data,files=_files,stream=True)
        _job = self.check_response(_upload)
        return _job['ID'] 
    
    @keyword  
    def upload_multiple_images(self,url,file_names,_data):
        """
        This keyword use to upload file to create job.
        The job ID will be returned.
        
        ``url`` (str) : webservice url.
        
        ``file_names`` (arr): Array containt all files name.
        
        ``data`` (dict): the dictionary contains transactionID, buttonID, buttonContext, sessionID 
        """
        _id = ""
        for _i in range(file_names.length - 1):
            if _i == 0:
                _id = self.upload_image(url, file_names[_i], _data)
            else:
                _data['transactionID'] = _id 
                self.upload_image(url, file_names[_i], _data)      
        return _id 
    
    @keyword  
    def download_image(self,url,file_name,_sessionID):
        """
        This keyword use to download image from job and save as the given file name
        
        ``url`` (str) : webservice url.
        
        ``file_names`` (str): files name.
        """
        _cookie = {"KFS_AUTH_THINCLIENT":_sessionID}
        
        _file = os.path.join(Path.home(),"Downloads",file_name)
        
        _download = requests.get(url,cookies=_cookie,stream=True)
        _download.raise_for_status()
        with open(_file, 'wb') as f:
            for chunk in _download.iter_content(chunk_size=128):
                f.write(chunk)
        return _file
    
    @keyword  
    def download_web_capture(self,url,file_name,auth):
        """
        This keyword use to download Kofax WebCapture from thinclient and save to disk as file_name.
        The path to downloaded file will be returned.
        
        ``url`` (str) : url to thinclient without login.html.
        
        ``file_name`` (str): path to save file.
        
        ``auth`` (dict): dictionary contains the authentication 
        """
        file_name = os.path.join(Path.home(),"Downloads",file_name)
        _login = requests.put(url + "/auth/",json=auth)
        _sessionID = _login.json()['SessionID']
        _cookie = {"KFS_AUTH_THINCLIENT":_sessionID}
        _download = requests.get(url + "/DownloadWebCaptureServiceInstaller/",cookies=_cookie,stream=True)
        _download.raise_for_status()
        with open(file_name, 'wb') as fd:
            for chunk in _download.iter_content(chunk_size=128):
                fd.write(chunk)
            return file_name
    
    @keyword     
    def get_css_property(self,locator,property_name):      
        """
        This function will return the value of the css property from the web element (defined by locator parameter)
        
        ``locator`` (WebElement locator) : the locator to identify the element
        
        ``property_name`` (str) : the name of css property to get value
        """
        element = self.lib.find_element(locator)
        return element.value_of_css_property(property_name)  
      
    
    @keyword      
    def get_element_demention(self,locator):
        """
        This keyword will return the demention of the image (defined by locator parameter) in array[with,height].
        
        ``locator`` (WebElement locator) : the locator to identify the element.
        """  
        width = self.get_css_property(locator, 'width')
        width = int(width.rsplit('px')[0])
        height = self.get_css_property(locator, 'height')
        height = int(height.rsplit('px')[0])
        return [width,height]
    
     
    @keyword
    def document_should_be_downloaded(self):
        """
        This keyword will check if the document is downloaded or not.
        """
        doc = os.path.join(Path.home(),"Downloads","document.pdf")
        doc_path = Path(doc)
        if doc_path.exists():
            os.remove(doc)
        else:    raise AssertionError("document.pdf file is not exists in Download Folder")    
    
    @keyword 
    def border_color_should_be(self, locator, expected):
        """
        This keyword will check the color of web element(defined by locator parameter) in format rbg(r,b,g).
        
        ``locator`` (WebElement locator) : the locator to identify the element.
        
        ``expected`` (RGB format): the rbg code Ex. rbg(0,0,0).
        """ 
        color = self.get_css_property(locator, 'border-color')
        if (color != expected):
            raise AssertionError("Actual color is '%s' while it should have been '%s'" % (color,expected))
    
    @keyword
    def draw_rectangle_at_coorfinates(self,locator,top_left,bottom_right):
        """
        This keyword use to draw a rectangle inside the web element(defined by locator parameter) from the top_left to the bottom_right.
        
        ``locator`` (WebElement locator) : the locator to identify the element.
        
        ``top_left`` (int): the top left.
        
        ``bottom_right`` (int): the bottom right.
        """ 
        action = ActionChains(self.lib.driver)
        action.move_to_element_with_offset(self.lib.find_element(locator),top_left,top_left)
        action.click_and_hold().move_by_offset(bottom_right,bottom_right).release()
        action.perform()
            
    @keyword
    def area_color_should_be(self,locator,color,xoffset,yoffset):
        """
        This keyword use to get the color (rgb format) of each pixel inside the web element(defined by locator parameter) with the top left and the bottom right after that compare with the given color (converted to rgb format).
        
        ``locator`` (string) : the locator to identify the element.
        
        ``color`` (string): the expect color (current support black/white).
        
        ``xoffset`` (int): the top left.
        
        ``yoffset`` (int): the bottom right.
        """ 
        jsfile = os.path.join(os.getcwd(),"SmokeTest","Pylibs","GetFixelColor.js")
        expect = self.lib.driver.execute_script(open(jsfile).read(),locator,color,int(xoffset),int(yoffset))
        if not expect:
            raise AssertionError("The color is not " + color + ".")      
        
    @keyword
    def area_color_should_not_be(self,locator,color,xoffset,yoffset):  
        """
        This keyword use to get the color (rgb format) of each pixel inside the web element(defined by locator parameter) with the top left and the bottom right after that compare with the given color (converted to rgb format).
        
        ``locator`` (string) : the locator to identify the element.
        
        ``color`` (string): the expect color (current support black/white).
        
        ``xoffset`` (int): the top left.
        
        ``yoffset`` (int): the bottom right.
        """ 
        jsfile = os.path.join(os.getcwd(),"SmokeTest","Pylibs","GetFixelColor.js")
        expect = self.lib.driver.execute_script(open(jsfile).read(),locator,color,int(xoffset),int(yoffset))
        if expect:
            raise AssertionError("The color is " + color + ".")      
              
    @keyword   
    def hold_and_click(self,locator,modifier=False):
        """
        This keyword use to hold the key before click to web element(defined by locator parameter).
        
        ``locator`` (WebElement locator) : the locator to identify the element.
        
        ``modifier`` (key): the key code.
        """
        if not isinstance(modifier, (str)):
            self.lib.info("Clicking element '%s'." % locator)
            self.lib.find_element(locator).click()
        else:
            modifier = self.parse_modifier(modifier)
            action = ActionChains(self.lib.driver)
            for item in modifier:
                action.key_down(item)
            action.click(self.lib.find_element(locator))
            for item in modifier:
                action.key_up(item)
            action.perform()
              
    @keyword   
    def hold_and_press(self,modifier,keys):
        """
        This keyword use to hold the modifier key before press the keys.
        
        ``keys`` (key) : the string represent the keys.
        
        ``modifier`` (key): the key code.
        """
        modifier = self.parse_modifier(modifier)
        action = ActionChains(self.lib.driver)
        for item in modifier:
            action.key_down(item)
        action.send_keys(keys)
        for item in modifier:
            action.key_up(item)
        action.perform()
            
            
    def parse_modifier(self, modifier):
        modifier = modifier.upper()
        modifiers = modifier.split('+')
        keys = []
        for item in modifiers:
            item = item.strip()
            if item == 'CTRL':
                item = 'CONTROL'
            if hasattr(Keys, item):
                keys.append(getattr(Keys, item))
            else:
                raise ValueError("'%s' modifier does not match to Selenium Keys"
                                 % item)
        return keys    
    
    def check_response(self,_response):
        if _response.status_code != 200:
            raise AssertionError("Fail to send request with response code " + _response.status_code + ".")
        _body = _response.json()
        if _body['ErrorCode'] != 0:
            raise AssertionError("Fail to send request with error code " + _body['ErrorCode'] + ", error:" + _body['ErrorMessage'])
        return _body