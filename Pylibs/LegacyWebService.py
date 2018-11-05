from robot.api.deco import keyword
from zeep import Client
from GetConfigures import GetConfigures
import time,os, requests

class LegacyWebService(object):
    ROBOT_LIBRARY_VERSION = '0.1'
    
    def __init__(self):
        self.cf = GetConfigures()
        
    def get_keyword_names(self):
        return [name for name in dir(self) if hasattr(getattr(self, name), 'robot_name')]  
    
    def create_client(self,service_name):
        _raw_url = "http://" + self.cf.host_name + "/Kofax/KFS/Legacy/WS/" + service_name + "/WSDL"  
        try: _cl = Client(_raw_url)
        except requests.exceptions.HTTPError as ex:  
            raise AssertionError(ex)   
            return _cl
        
    @keyword  
    def ping_server(self):
        """
        This keyword use to check the server satus.
        
        ``return`` None or error message.
        """
        cl = self.create_client("PingService")
        return cl.service.ping()
    
    @keyword  
    def user_login(self, user):
        """
        This keyword use to trigger the login service and get the session ID.
        
        ``user`` (dict) contain user parameter.
        """
        cl = self.create_client("UserLoginService")
        
        _response = cl.service.login(user['UserID'],user['Password'],self.cf.mfp_emulator['DeviceName'])
        self.check_response(_response)
        self.cf.session_id = _response["sessionID"]  
    
    @keyword  
    def register_device(self):
        """
        This keyword use to trigger the updateDeviceInfo service which create a new device on server 
        with the given data.
        """
        cl = self.create_client("DeviceService")
        
        _response = cl.service.updateDeviceInfo(
            wscClientID = self.cf.mfp_emulator['DeviceName'],
            macAddress = self.cf.mfp_emulator['MacAddress'],
            ipAddress = self.cf.mfp_emulator['IP'],
            hostname = self.cf.mfp_emulator['HostName'],
            model = self.cf.mfp_emulator['DeviceModel'],
            devicename = self.cf.mfp_emulator['DeviceName']
        )
        self.check_response(_response)
    
    @keyword  
    def create_job(self, user):
        """
        This keyword use to trigger the startJob service which create a new job without image and
        data.
        
        ``user`` (dict) contain user parameters.
        
        ``return`` (string) JobId for sendImage service.
        """
        cl = self.create_client("StartJobService")
        
        _request = cl.get_type("ns1:WscRequest")
        
        _wsRequest = _request(
            userName = user['UserID'],
            password = user['Password'],
            wscClientId = self.cf.mfp_emulator['DeviceName'],
            jobId = self.cf.mfp_emulator['DeviceName'] + "-" + str(time.time())
        )
        
        _response = cl.service.startJob(wsRequest=_wsRequest)
        self.check_response(_response)
        
        return _response["jobId"]
    
    @keyword  
    def send_job(self, user, job):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``user`` (dict) contain user parameters.
        
        ``job`` (dict) contain job parameters.
        """
        self.user_login(user)
        
        _destination = self.get_destination(user, job["Destination"])
        
        _index_fields = self.get_index_fields(_destination)
        
        _fields = self.set_index_fields(_index_fields, job["Fields"])
        
        self.validate_fields_value(_destination, _fields[1])
        
        _jobId = self.create_job(user)
        
        #Configure destination
        cl = self.create_client("SendImageService2")
        
        _destination_type = cl.get_type("ns3:WscDestination")
        
        _destinationws = _destination_type(
            id = _destination["ButtonID"],
            indexFields = _fields[0],
            shortcutName = _destination["Name"],
            shortcutTypeOrdinal = _destination["ShortcutType"]
        )
        
        #Configure request
        _request = cl.get_type("ns1:WscSendImageRequest")
        
        _wsRequest = _request(
            userName = user['UserID'],
            password = user['Password'],
            wscClientId = self.cf.mfp_emulator['DeviceName'],
            jobId = _jobId,
            destination = _destinationws,
            buttonContext = _destination["ButtonContext"]
        )
        
        for _file_name in job["FileName"]:
            #_file_path = os.path.join(os.getcwd(),"SmokeTest-WS","TestResource","Documents",_file_name)
            _file_path = os.path.join("C:\OneDrive\Documents\Automation\KFS-Robot\SmokeTest-WS\TestResource\Documents",_file_name)
            with open(_file_path,'rb') as _file:
                _response = cl.service.sendImage(wsRequest=_wsRequest, image=_file.read())
                self.check_response(_response)
        
        _wsFinish = _request(
            userName = user['UserID'],
            password = user['Password'],
            wscClientId = self.cf.mfp_emulator['DeviceName'],
            jobId = _jobId,
            done = True,
            destination = _destinationws,
            buttonContext = _destination["ButtonContext"]
        )
        
        _response = cl.service.sendImage(wsRequest=_wsFinish)
        self.check_response(_response)
    
    @keyword  
    def validate_fields_value(self, destination, fields):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``user`` (dict) contain user parameters.
        
        ``job`` (dict) contain job parameters.
        """
        _fields = self.get_index_fields(destination, fields, type=2)
        
        for _field in _fields:
            if _field["ErrorMessage"] is not None:
                raise AssertionError('Validation failed for field "{0}" with error: {1}'.format(_field["DisplayLabel"],_field["ErrorMessage"]))
    
    @keyword
    def set_field_validation(self, destination, fields, current_field):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``user`` (dict) contain user parameters.
        
        ``job`` (dict) contain job parameters.
        """
        _fields = self.get_index_fields(destination, fields, current_field, 0)
        
        return _fields
    
    @keyword
    def verify_field_value(self, actuals, expects):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``user`` (dict) contain user parameters.
        
        ``job`` (dict) contain job parameters.
        """
        _keys = expects.keys()
        _exist = False
        
        for _key in _keys:
            for _actual in actuals:
                if _actual["DisplayLabel"] == _key:
                    if _actual["Value"] != expects[_key]:
                        raise AssertionError('The value of field "{0}" is "{1}" but expect "{2}"'.format(_actual["DisplayLabel"],_actual["Value"],expects[_key]))
                    _exist = True
            if not _exist:
                raise AssertionError('The field "{0}" is not exist in this shortcut'.format(_key))
    
    @keyword        
    def verify_field_error(self, index_fields, field_name, error_message=None):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``index_fields`` (dict) actual index fields.
        
        ``field_name`` (str) the fields name to verify.
        
        ``error_message`` (str) The expected error message.
        """
        _exist = False
        
        for _field in index_fields:
            if _field["DisplayLabel"] == field_name:
                if _field["ErrorMessage"] != error_message:
                    raise AssertionError('The error message of field "{0}" is "{1}" but expect "{2}"'.format(_field["DisplayLabel"],_field["ErrorMessage"],error_message))
                _exist = True
        if not _exist:
                raise AssertionError('The field "{0}" is not exist in this shortcut'.format(field_name))
        
    @keyword  
    def set_index_fields(self, fields, values):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``user`` (dict) contain user parameters.
        
        ``job`` (dict) contain job parameters.
        """
        
        _keys = values.keys()
        
        _fields_request = []
        
        for _field in fields:
            for _key in _keys:
                if _field["DisplayLabel"] == _key:
                    self.set_field_value(_field, values[_key])
            
            _field_request = {
                    "dataType":_field["DataType"],
                    "displayName":_field["DisplayLabel"],
                    "isBatchClassIndexFieldString":False,
                    "isDocumentClassIndexFieldString":False,
                    "name":_field["Name"],
                    "value":_field["Value"]
                }
            
            _fields_request.append(_field_request)
            
        return [_fields_request,fields]
                    
    def set_field_value(self, field, value):
        if field["SuggestedValues"]:
            for _suggest in field["SuggestedValues"]:
                if _suggest["DisplayValue"] == value:
                    field["Value"] = _suggest["Value"]
        else: field["Value"] = value     
    
    @keyword  
    def get_destination(self, user, name):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``user`` (dict) contain user parameters.
        
        ``job`` (dict) contain job parameters.
        """
        cl = self.create_client("GetDeviceDestinationsService")
        
        _request = cl.get_type("ns1:WscDeviceDestinationsRequest")
        
        _wsRequest = _request(
            UserName = user['UserID'],
            Password = user['Password'],
            WscClientId = self.cf.mfp_emulator['DeviceName'],
            CurrentProfileID = 0,
            CurrentProfileTimestamp=0,
            SessionID = self.cf.session_id
        )
        
        _response = cl.service.getDeviceDestinations(wsRequest=_wsRequest)
        self.check_response(_response)
        
        _destinations = _response["Destinations"]
        _exist = False
        
        for destination in _response["Destinations"]:
            if destination["Name"] == name:
                _destinations = destination
                _exist = True
                break
        
        if not _exist:
            raise AssertionError('No shortcut with name "{0}" associated with device "{1}" or user "{2}"'.format(name, self.cf.mfp_emulator['DeviceName'],user['UserID']))
                
        return _destinations
    
    @keyword 
    def get_index_fields(self, destination, fields=None, current_field=None,type=1):
        """
        This keyword use to trigger the sendImage service which upload images and
        data using jobid.
        
        ``user`` (dict) contain user parameters.
        
        ``job`` (dict) contain job parameters.
        """
        cl = self.create_client("GetDynamicFieldsAndValidateService")
        
        _request = cl.get_type("ns1:WscDynamicFieldsAndValidateRequest")
        
        _wsRequest = _request(
            WscClientId = self.cf.mfp_emulator['DeviceName'],
            Context = 2,
            GlobalID = destination["ButtonID"],
            IndexFields = fields,
            CurrentField = current_field,
            ButtonContext = destination["ButtonContext"],
            SessionID = self.cf.session_id,
            MultiplexRequestType = type
        )
        
        _response = cl.service.getDynamicFieldsAndValidate(wsRequest=_wsRequest)
        self.check_response(_response)
        
        return _response["IndexFields"]
    
    def check_response(self, response):
        try:
            if response["resultCode"] != 0:
                raise AssertionError('The request failed with the error message: {0}'.format(response["errorMessage"]))
        except Exception:
            if response["ResultCode"] != 0:
                raise AssertionError('The request failed with the error message: {0}'.format(response["ErrorMessage"]))