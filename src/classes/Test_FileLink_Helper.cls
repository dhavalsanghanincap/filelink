@isTest
public class Test_FileLink_Helper {

    @isTest
    static void testGetStringBodyParam() {
        RestRequest req = new RestRequest();
        RestContext.request = req;
        
        RestContext.request.requestBody = Blob.valueOf('{' +
            '"a": "banana"' +
        '}');
        
        System.assertEquals('banana', FileLink_Helper.getStringBodyParam('a'));
    }
}