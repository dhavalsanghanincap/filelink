/*
 * Block comments with details of changes
 */
global class Upload_File_Controller
{
    Global String objectId {get;set;}
    public String RedirectURL {get;set;}
    public External_File_Relationship__c efrRecord{get;set;}
    public String defaultService{get;set;}
    
    public Upload_File_Controller()
    {
        System.debug(ApexPages.currentPage().getParameters());
        RedirectURL =  ApexPages.currentPage().getParameters().get('RedirectURL');
        defaultService = Factory_Service.getDefaultServiceName();
    }
    
    public Upload_File_Controller(ApexPages.StandardController stdController)
    {
        Sobject so = (Sobject)stdController.getRecord();
        RedirectURL =  ApexPages.currentPage().getParameters().get('RedirectURL');

    }
    
    public PageReference RedirectToFileLink(){
        PageReference pageRef = new PageReference('/apex/'+RedirectURL);
        //url = pageRef.getURL();
        pageref.getParameters().put('ObjectId',objectId);
        //shouldRedirect = true;
        return pageRef;
    }
    
    @RemoteAction
    global static void fileUploaded(String externalID, String url, String objectIdRemote){
        External_File__c ef = pullExternalFilerecord(externalID,  url,  objectIdRemote);
        External_File_Relationship__c efr = insertExternalFileRelationship(objectIdRemote,ef.id,'');
        
    }

    @RemoteAction
    global static void fileUploadedwithTag(String externalID, String url, String objectIdRemote,String[] tags){
        
        External_File__c ef = pullExternalFilerecord(externalID,  url,  objectIdRemote);
        
        string selectedTag = '';
        if(tags != null && tags.size()>0){
            selectedTag = string.join(tags,';');
            
        }
        system.debug('=====>'+selectedTag);
        External_File_Relationship__c efr = insertExternalFileRelationship(objectIdRemote,ef.id,selectedTag);
        System.debug(efr.id);
        
    }

    public static External_File_Relationship__c insertExternalFileRelationship(String externalID, String externalFileID,String tags){
        External_File_Relationship__c efr = new External_File_Relationship__c();
        efr.FileLInk__Object_ID__c = externalID;
        efr.FileLInk__External_File__c = externalFileID;
        efr.FileLInk__Tags__c = tags;
        insert efr;
        return efr;
    }

    public static External_File__c pullExternalFilerecord(String externalID, String url, String objectIdRemote){
        System.debug('----> ObjectIdRemote: '+objectIdRemote);
        list<External_File__c> efs = [select id from External_File__c where Public_URL__c = :url or FileLInk__External_ID__c = :externalId];
        External_File__c ef;
        // Should apply to cloudinary only as SF Files already saves the Ext File. 
        if(efs.size() == 0 ){
            ef = new External_File__c();
            ef.FileLInk__External_ID__c = externalId;
            ef.Public_URL__c = url;
            ef.Service__c = 'Cloudinary';

            // Attempt to get the filename from the url for Cloudinary upload.
            if (url.contains('/')) {
                String finalSectionOfUrl = url.substringAfterLast('/');
                // Verify there is an extension just by checking for a dot.
                if (finalSectionOfUrl.contains('.')) {
                    ef.Filename__c = finalSectionOfUrl;
                }
            }
            insert ef;
        } else {
             ef = efs[0];
        }
        return ef;
    }
}