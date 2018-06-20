@isTest
public class Test_Factory_Service
{
    static testMethod void Test_Factory_Service()
    {
        Service service = Factory_service.createDefaultService();
        Service service2 = Factory_service.createService('Cloudinary');
        //System.assertEquals(service.serviceName, service2.serviceName);
        System.assertEquals('Cloudinary', service2.serviceName);
    }
    
    static testMethod void Test_Find_By_External_Id()
    {
        Service service = Factory_service.createDefaultService();
        
        External_File__c file = service.findFileByExternalId('abc');
        
        System.assertEquals(file, null);
    }
    
    static testMethod void Test_Relate_File() {
        External_File__c f = new External_File__c();
        insert f;
        Case c = new Case();
        insert c;
        
        Service service = Factory_service.createDefaultService();
        
        List<External_File_Relationship__c> rels = service.relateFile(f, new List<String>{ c.Id });
        
        System.assertEquals(rels[0].Object_Id__c, c.Id);
        
    }
    
    static testMethod void Test_Relate_File_Tags() {
        External_File__c f = new External_File__c();
        insert f;
        
        Case c = new Case();
        insert c;
        
        Service service = Factory_service.createDefaultService();
        
        List<External_File_Relationship__c> rels = service.relateFile(f, new List<String>{ c.Id }, new List<String>{ 'Create', 'Update' });
        
        System.assertEquals(rels[0].Object_Id__c, c.Id);
        System.assert(rels[0].Tags__c.contains('Create'));
        System.assert(rels[0].Tags__c.contains('Update'));
    }
    
    static testMethod void Test_Factory_Service_NoneFound()
    {
        Exception except;
        try{
            Service service = Factory_service.createService('SERICETHATDOESNtEXIST');
        }catch(Exception e){
            except = e;
        }
        System.assert(except != null);
        System.assertEquals(except.getMessage(), 'Service SERICETHATDOESNtEXIST cannot be found');
    }
    
    static testMethod void Test_Factory_Service_SalesforceFiles()
    {
        Exception except;
        try{
            Service service = Factory_service.createService('Salesforce Files');
            System.assertEquals('Salesforce', service.serviceName);
        }catch(Exception e){
            except = e;
        }
        
    }

    static testMethod void testgetDefaultServiceName(){
        File_Upload_Setting__mdt defaultSettings = [select id,API_Key__c,Private_Key__c,Config_JSON__c,Service__c from File_Upload_Setting__mdt where Is_Default__c = true limit 1];
        
       String defaultsetting=Factory_Service.getDefaultServiceName();
       System.assertEquals(defaultSettings.Service__c,defaultsetting);
    }
}