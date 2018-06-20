@isTest
public class Test_FileLink_Service_Wrapper {
 
    @isTest
    static void testShortcutsMethod() { 
        Case cas = new Case();
        insert cas;
        FileLink_Service_Wrapper fsw=new FileLink_Service_Wrapper();
        ApexPages.StandardController sc = new ApexPages.StandardController(cas);
        fsw=new FileLink_Service_Wrapper(sc);

        FileLink_Service_Wrapper.handleRemote('FileLink_FileService', 'fileUpload', '[""]');

        RestResponse res = new RestResponse();
        RestRequest req = new RestRequest();
             req.requestBody = Blob.valueOf('{' +
             '"service": "Base311_Service_ServiceType",' +
             '"method": "getActiveServiceTypes",' +
             '"data": "[true]"'+
          '}');
         
          RestContext.request = req;
          RestContext.response = res;
          FileLink_Service_Wrapper.handleRest();
    }
}