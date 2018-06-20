@RestResource(urlMapping='/Filelink/*')
global with sharing class Filelink_REST {

    @HttpPost
    global static RESTResponse Filelink_REST(File file, String serviceName) {
         RESTResponse response = new RESTResponse();
        try{
            Service fileService;
            if(serviceName == null){
                fileService = Factory_Service.createDefaultService();
            }else{
                fileService = Factory_Service.createService(serviceName) ;
            }
           response.file = fileService.uploadFile(file);
        }catch(Exception e){
            response.Exceptions = e.getMessage();
        }

        

        return response;
    }

    Global class RESTResponse{
        public String Exceptions;
        public External_File__c file;
    }

}