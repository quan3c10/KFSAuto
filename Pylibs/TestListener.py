'''
Created on Jun 25, 2018

@author: sqaadmin
'''
from robot.libraries.BuiltIn import BuiltIn

class TestListener(object):
    '''
    classdocs
    '''
    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
    ROBOT_LISTENER_API_VERSION = 2


    def __init__(self):
        '''
        Constructor
        '''
        self.ROBOT_LIBRARY_LISTENER = self
        self.selenium = BuiltIn().get_library_instance('SeleniumLibraryTest')
        
    def _end_keyword(self, name, attrs):
        pass
            
    def _start_keyword(self, name, attrs):
        self.wait_for_page()
            
    def _start_suite(self, name, attrs):
        pass
        
    def _end_suite(self, name, attrs):
        pass
        
    def _start_test(self, name, attrs):
        pass
    
    def _end_test(self, name, attrs):
        pass
    
    def _log_message(self,message):
        pass
    
    def _message(self,message):
        pass
    
    def _library_import(self, name, attrs):
        pass
    
    def _resource_import(self, name, attrs):
        pass
    
    def _verifable_import(self, name, attrs):
        pass
    
    def _output_file(self, path):
        pass
    
    def _log_file(self, path):
        pass
    
    def _report_file(self, path):
        pass
    
    def _xunit_file(self, path):
        pass
    
    def _debug_file(self, path):
        pass
    
    def close(self):
        pass
    
    def wait_for_page(self):
        self.selenium.wait_until_element_is_not_visible('.blockUI')
        
    def handle_alert(self):
        try:
            alert = self.selenium.switch_to.alert()
            alert.close()
        except Exception as ex:
            pass    