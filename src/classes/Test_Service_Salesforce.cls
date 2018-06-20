@isTest
public class Test_Service_Salesforce {

    @isTest
    public static void testSalesforceService(){
        Service_Salesforce salesforce = new Service_Salesforce(new File_Upload_Setting__mdt());
        Account account = new Account();
        account.name = 'test';
        insert account;
        
        File file = new File();
        file.file = 'Test';
        file.FileName = 'test';
        file.folder = 'test';
        list<String> objectIds =  new list<String>();
        objectIds.add(account.id);
        file.objectIds =objectIds;
            
            
        salesforce.UploadFile(file);
        
        list<External_File_Relationship__c> eFR = [select id from External_File_Relationship__c where Object_ID__c = :account.id];
        System.assertEquals(eFR.size(),1);
    }
    
}