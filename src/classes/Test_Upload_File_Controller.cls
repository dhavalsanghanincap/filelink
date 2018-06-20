@isTest
public class Test_Upload_File_Controller {

    @isTest
    public static void testRedirectToFileLink(){
        Case cas = new Case();
        insert cas;
        
        PageReference pageRef = Page.Upload_File;
        system.Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('RedirectURL', '/'+cas.id); 
        Upload_File_Controller controllerRecord = new Upload_File_Controller();
        controllerRecord.RedirectToFileLink();        
        }
        
     @isTest
    public static void testRedirectToFileLinkExtn(){
        Case cas = new Case();
        insert cas;
        
        PageReference pageRef = Page.Upload_File;
        system.Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('RedirectURL', '/'+cas.id); 
        ApexPages.StandardController sc = new ApexPages.StandardController(cas);
        Upload_File_Controller controllerRecord = new Upload_File_Controller(sc);
        controllerRecord.RedirectToFileLink();        
        }      
     @isTest
    public static void testfileUploaded(){
        Case cas = new Case();
        insert cas;
        
        External_File__c ef = new External_File__c();
        ef.FileLInk__External_ID__c = 'test';
        ef.Public_URL__c = '/test';
        ef.Service__c = 'Cloudinary';
        insert ef;

        External_File_Relationship__c efr = new External_File_Relationship__c();
            efr.FileLInk__Object_ID__c = cas.Id;
            efr.FileLInk__External_File__c = ef.id;
        insert efr;

         Upload_File_Controller.fileUploaded('test','/test',cas.Id);
         Upload_File_Controller.fileUploadedwithTag('test','/test',cas.Id,new String[]{'Create','Update'});
         External_File__c expexfile= Upload_File_Controller.pullExternalFilerecord('test1','/test1',String.valueOF(case.Id));
         System.assert(expexfile != null);
        }
       
}