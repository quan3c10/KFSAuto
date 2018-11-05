'''
Created on Sep 7, 2018

@author: sqaadmin
'''
import os 
import xml.etree.ElementTree as et

class GetConfigures(object):
    '''
    classdocs
    '''
#     @property
    def parent_path(self):
        return os.path.dirname(os.path.abspath(__file__))
        #return os.getcwd()

    def __init__(self):
        '''
        Constructor
        '''
        #self.root = et.parse(os.path.join(self.parent_path(),"TestConfig.xml")).getroot()
        self.root = et.parse(os.path.join("C:\OneDrive\Documents\Automation\KFS-Robot","TestConfig.xml")).getroot()
        self._id = None
    
    def find_by_xpath(self, xpath):
        _instance = self.root.findall(xpath)
        if len(_instance) == 1:
            return _instance[0].text
        else: raise Exception("More than 1 instance with xpath {0} found in configure file".format(xpath))
    
    def find_by_name(self, name):
        _instance = self.root.iter(name)
        _value = next(_instance).text
        try: next(_instance)
        except StopIteration: return _value
        except Exception: raise Exception("More than 1 instance with name {0} found in configure file".format(name))  
    
    @property
    def session_id(self):
        return self._id
    
    @session_id.setter
    def session_id(self, _id):
        self._id = _id
    
    @property
    def host_name(self):
        return self.find_by_name("KFSServer")
    
    @property
    def log_lv(self):
        return self.find_by_name("DebugMode")
    
    @property
    def output_directory(self):
        return self.find_by_name("TestOutputDirectory")
    
    @property
    def browser(self):
        return self.find_by_name("Browser")
    
    @property
    def build_number(self):
        return self.find_by_name("BuildNumber")
    
    @property
    def admin_user(self):
        _admin = {
                'UserID':self.find_by_name("KFSAdminUser"),
                'UserName':self.find_by_name("KFSAdminUserName"),
                'Password':self.find_by_name("KFSAdminPassword")
            }
        return _admin
    
    @property
    def group(self):
        _group = {
                'GroupName':self.find_by_name("KFSUserGroup"),
                'UserID':self.find_by_name("KFSUser"),
                'UserName':self.find_by_name("KFSUserName"),
                'Password':self.find_by_name("KFSUserPassword")
            }
        return _group
    
    @property
    def group2(self):
        _group2 = {
                'GroupName':self.find_by_name("KFSUserGroup2"),
                'UserID':self.find_by_name("KFSUser2"),
                'UserName':self.find_by_name("KFSUser2Name"),
                'Password':self.find_by_name("KFSUser2Password")
            }
        return _group2
    
    @property
    def domain_group(self):
        domain_group = {
                'GroupName':self.find_by_name("KFSDomainUserGroup"),
                'UserID':self.find_by_name("KFSDomainUser"),
                'UserName':self.find_by_name("KFSDomainUserName"),
                'Password':self.find_by_name("KFSDomainUserPassword")
            }
        return domain_group
    
    @property
    def domain_group2(self):
        domain_group2 = {
                'GroupName':self.find_by_name("KFSDomainUserGroup2"),
                'UserID':self.find_by_name("KFSDomainUser2"),
                'UserName':self.find_by_name("KFSDomainUser2Name"),
                'Password':self.find_by_name("KFSDomainUser2Password")
            }
        return domain_group2
    
    @property
    def mfp_emulator(self):
        mfp_emulator = {
                'DeviceName':self.find_by_name("MFP1_DeviceName"),
                'HostName':self.find_by_name("MFP1_HostName"),
                'IP':self.find_by_name("MFP1_IP"),
                'MacAddress':self.find_by_name("MFP1_MACAddress"),
                'DeviceModel':self.find_by_name("MFP1_DeviceModel")
            }
        return mfp_emulator
    
    @property
    def scanner(self):
        scanner = {
                'Path':self.find_by_name("USBRDR_Path"),
                'HostName':self.find_by_name("USBRDR_Server"),
                'Port':self.find_by_name("USBRDR_Port"),
                'VID':self.find_by_name("USBRDR_VID"),
                'PID':self.find_by_name("USBRDR_PID"),
                'USBPort':self.find_by_name("USBRDR_USBPort")
            }
        return scanner
    
    @property
    def share_point(self):
        share_point = {
                'SiteURL':self.find_by_name("SharePointSiteURL"),
                'UserName':self.find_by_name("SharePointUser"),
                'Password':self.find_by_name("SharePointUserPassword")
            }
        return share_point
    
    @property
    def email(self):
        email = {
                'UserName':self.find_by_name("EmailUser"),
                'Password':self.find_by_name("EmailUserPassword"),
                'Type':self.find_by_name("EmailServerType"),
                'Host':self.find_by_name("EmailHost"),
                'Port':self.find_by_name("EmailPort"),
                'SSL':self.find_by_name("EmailSSL")
            }
        return email
    
    @property
    def folder(self):
        folder = {
                'UserName':self.find_by_name("FolderUser"),
                'Password':self.find_by_name("FolderUserPassword"),
                'Path':self.find_by_name("FolderPath")
            }
        return folder
    
    @property
    def fax(self):
        fax = {
                'UserName':self.find_by_name("FaxUser"),
                'Password':self.find_by_name("FaxUserPassword"),
                'Host':self.find_by_name("FaxHost"),
                'Type':self.find_by_name("FaxServerType")
            }
        return fax