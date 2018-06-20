@isTest
public class Test_Layout_Controller_Ext
{
    static testMethod void Test_Layout_Controller_Ext()
    {
        Case cas = new Case();
        insert cas;
        
        External_File__c ef = new External_File__c();
        ef.FileLInk__External_ID__c = 'test';
        ef.Public_URL__c = 'test';
        ef.Service__c = 'Cloudinary';
        insert ef;
        
            External_File_Relationship__c efr = new External_File_Relationship__c();
            efr.FileLInk__Object_ID__c = cas.Id;
            efr.FileLInk__External_File__c = ef.id;


        insert efr;
        
        ApexPages.StandardController stdLead = new ApexPages.StandardController(cas);
        Layout_Controller_Ext layoutExt  = new Layout_Controller_Ext();
          PageReference pageRef = new PageReference('/apex/Service_Request');
        system.Test.setCurrentPage(pageRef);
        layoutExt.getefrs();
        layoutExt.ToggleuploadFile();
        //System.assertEquals(so.id, cas.Id);
        
        
    }
    
    static testMethod void Test_Layout_Controller_Ext_RemoveFileRelationship()
    {
        Case cas = new Case();
        insert cas;
        
        External_File__c ef = new External_File__c();
        ef.FileLInk__External_ID__c = 'test';
        ef.Public_URL__c = 'test';
        ef.Service__c = 'Cloudinary';
        insert ef;
        
        External_File_Relationship__c efr = new External_File_Relationship__c();
        efr.FileLInk__Object_ID__c = cas.Id;
        efr.FileLInk__External_File__c = ef.id;

        insert efr;
        
        //set deleted flag
        Set<Id> efrId = new Set<Id>();
        efrId.add(efr.Id);
        
        External_File_Relationship.removeFileRelationship(efrId);
    }
}