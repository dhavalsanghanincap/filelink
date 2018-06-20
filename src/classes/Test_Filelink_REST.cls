/*
 * Block comments with details of changes
 */
@isTest
public class Test_Filelink_REST
{
    @isTest
    static void Test_Filelink_REST()
    {
        Test.setMock(HttpCalloutMock.class, new Test_Mock_Cloudinary());
        File file = Test_Helper_Stock_Objects.getStockFile();
        
        Test.starttest();
            Filelink_REST.RESTResponse response = Filelink_REST.Filelink_REST(file,null);
        Test.stoptest();
        
        //System.assertEquals(response.exceptions, null);
        //list<External_File__c> exFiles = [select id from External_File__c where id = :response.file.Id];
        //System.assertEquals(exFiles.size(), 1);
    }
    
    @isTest
    static void Test_Filelink_REST_Cloudinary()
    {
        Test.setMock(HttpCalloutMock.class, new Test_Mock_Cloudinary());
        File file = Test_Helper_Stock_Objects.getStockFile();
        
        Test.starttest();
            Filelink_REST.RESTResponse response = Filelink_REST.Filelink_REST(file,'Cloudinary');
        Test.stoptest();
        
        System.assertEquals(response.exceptions,null);
        list<External_File__c> exFiles = [select id from External_File__c where id = :response.file.Id];
        System.assertEquals(exFiles.size(), 1);
    }

    @isTest
    static void Test_Filelink_REST_CloudinaryURL()
    {
        Test.setMock(HttpCalloutMock.class, new Test_Mock_Cloudinary());
        File file = Test_Helper_Stock_Objects.getStockFileWithURL();
        
        Test.starttest();
            Filelink_REST.RESTResponse response = Filelink_REST.Filelink_REST(file,'Cloudinary');
        Test.stoptest();
        
        System.assertEquals(response.exceptions,null);
        list<External_File__c> exFiles = [select id from External_File__c where id = :response.file.Id];
        System.assertEquals(exFiles.size(), 1);
    }
    @isTest
    static void testServiceCloudinary(){
        Test.setMock(HttpCalloutMock.class, new Test_Mock_Cloudinary());
        File file = Test_Helper_Stock_Objects.getStockFileWithURL();
        File_Upload_Setting__mdt defaultSettings = [select id,API_Key__c,Private_Key__c,Config_JSON__c,Service__c from File_Upload_Setting__mdt where Config_JSON__c != null limit 1];
      if(defaultSettings != null){
        Service_Cloudinary sc=new Service_Cloudinary(defaultSettings);
        String apiSecret=sc.getApiSecret();
        System.assertEquals(apiSecret,defaultSettings.FileLInk__Private_Key__c);
       
        String apiKey=sc.getAPIKey();
        System.assertEquals(apiKey,defaultSettings.API_Key__c);

        String cloudname=sc.getCloudName();
        System.assertEquals(cloudname,'filelink');

        String signed=sc.getSigned();
        String signed1=sc.getSigned('test');
        
      }
       
    }
}