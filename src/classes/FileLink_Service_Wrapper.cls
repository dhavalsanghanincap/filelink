/**
* @author 
* @date 
* @group 
* @group-content
* @description 
*/
@RestResource(urlMapping= '/files') 
global class FileLink_Service_Wrapper {
    
    global FileLink_Service_Wrapper() {}
    
    global FileLink_Service_Wrapper(ApexPages.StandardController ca) {}
    
    /**
* @description 
* @param 
* @param 
* @return 
* @example
*/
    private static Object serializeParam(Object item, Type t) {
        try {
            return JSON.deserialize(JSON.serialize(item), t);
        }
        catch (Exception e) {
            System.debug(e);
            return null;
        }
    }
    
    /**
* @description 
* @param 
* @param 
* @return 
* @example
*/ 
    @RemoteAction
    global static Object handleRemote(String service, String method, String params) { 
        List<Object> finalParams = (List<Object>) JSON.deserializeUntyped(params);
        return FileLink_Service_Wrapper.mapServiceMethod(service, method, finalParams);
    }
    
    /**
* @description 
* @param 
* @param 
* @return 
* @example
*/
    @HttpPost
    global static void handleRest() {
        String service = FileLink_Helper.getStringBodyParam('service');
        String method = FileLink_Helper.getStringBodyParam('method');
        List<Object> params = (List<Object>) JSON.deserializeUntyped(FileLink_Helper.getStringBodyParam('data'));
        Object res = FileLink_Service_Wrapper.mapServiceMethod(service, method, params);
        
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(res));
        RestContext.response.headers.put('Content-Type', 'application/json');
    }
    
    private static Object mapServiceMethod(String service, String method, List<Object> params) {
        try {
            if(service == 'FileLink_FileService') {
                return mapFileServiceMethod(method, params);
            }
            else return null;
        }
        catch (Exception e) {
            System.debug(e);
            return null;
        }
    }
    
    private static Object mapFileServiceMethod(String method, List<Object> params) {
        if(method == 'fileUpload') {
            Service fileService = Factory_Service.createDefaultService();
            return fileService.uploadFile((File) serializeParam(params[0], File.class));
        }
        
        return null;
    }
    
}