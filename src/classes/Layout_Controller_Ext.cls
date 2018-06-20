/*
 * Block comments with details of changes
 */
Global class Layout_Controller_Ext
{
    public Id sobjectId{get;set;}
    public String externalFileID{get;set;}
    //public list<External_File_Relationship__c> efrs {get;set;}
    Global boolean uploadFile {get;set;}{uploadFile = false;}
    Global Layout_Controller_Ext()
    {
        
    }
    
    public list<External_File_Relationship__c> getefrs(){
        if(sobjectId == null){
            sobjectId =  ApexPages.currentPage().getParameters().get('ObjectId');
        }
        return External_File_Relationship.getExternalFileRelationship(sobjectId);
    }
    
    Global PageReference toggleUploadFile(){
        SYstem.debug('toggleUploadFile');
        uploadFile = !uploadFile;
        return null;
    }
    
    Global PageReference falseUploadFile(){
        SYstem.debug('falseUploadFile');
        uploadFile = false;
        return null;
    }


    public void deleteFileRelationship(){ 
         //Get default service
        externalFileID = ApexPages.currentPage().getParameters().get('recordID');
        /*Service defaultService = Factory_Service.createDefaultService();
        system.debug('=====>'+externalFileID);
         system.debug('=====>'+defaultService);
        if(externalFileID != null && defaultService.ServiceName != 'Salesforce'){
            Delete [Select id FROM FileLInk__External_File_Relationship__c WHERE id=:externalFileID] ;
        }else if(externalFileID != null && defaultService.ServiceName == 'Salesforce'){
            //Logic to remove the distribution record
            /*list<ContentDistribution> distributionList = new list<ContentDistribution>();
            distributionList = [Select id FROM ContentDistribution WHERE RelatedRecordId =:externalFileID];
            if(distributionList.size()>0){
                delete distributionList;
            }
            
            //Fetch external file rel details
            FileLInk__External_File_Relationship__c extRel = [SELECT 
                                                              		Id,
                                                              		FileLInk__External_File__c,
                                                              		FileLInk__Object_ID__c,
                                                              		FileLInk__External_File__r.FileLInk__External_ID__c 
                                                              FROM 
                                                              	FileLInk__External_File_Relationship__c 
                                                              WHERE 
                                                              	Id=:externalFileID];
            
            if(extRel != null)
            { 
                if(extRel.FileLInk__External_File__c != null && extRel.FileLInk__External_File__r.FileLInk__External_ID__c!= null)
                {
                    //delete contentdistribution
                    delete [SELECT Id FROM ContentDistribution WHERE ContentDocumentId=:extRel.FileLInk__External_File__r.FileLInk__External_ID__c AND RelatedRecordId=:extRel.FileLInk__Object_ID__c];
                    
                    //delete ContentDocumentLink
                    //delete [SELECT Id FROM ContentDocumentLink WHERE Id=:extRel.FileLInk__External_File__r.FileLInk__External_ID__c];
                }
                
                //delete external file rel
                delete [Select id FROM FileLInk__External_File_Relationship__c WHERE id=:externalFileID] ;
            }
        }*/
        
        //delete file relationship
        External_File_Relationship.removeFileRelationship(new Set<Id>{externalFileID});
    }
    
}