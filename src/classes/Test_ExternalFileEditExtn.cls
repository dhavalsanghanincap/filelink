@isTest
public with sharing class Test_ExternalFileEditExtn {
    @isTest
    public static void test(){

        Case cas = new Case();
        insert cas;
        
        Case cas2 = new Case();
        insert cas2;
        
        External_File__c ef = new External_File__c();
        ef.FileLInk__External_ID__c = 'test';
        ef.Public_URL__c = 'test';
        ef.Service__c = 'Cloudinary';
        insert ef;
        
        External_File_Relationship__c efr = new External_File_Relationship__c();
        efr.FileLInk__Object_ID__c = cas.Id;
        efr.FileLInk__External_File__c = ef.id;


        insert efr;
        PageReference pageRef = Page.ExternalFileEdit;
        system.Test.setCurrentPage(pageRef);
        System.currentPageReference().getParameters().put('objectID', efr.Id);
        //System.currentPageReference().getParameters().put('externalRelationShipID', efr.Id);

        ExternalFileEditExtn extn = new ExternalFileEditExtn();
        
        extn.OnSave();
        extn.Cancel();

    }
}