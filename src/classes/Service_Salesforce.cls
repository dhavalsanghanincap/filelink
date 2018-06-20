public class Service_Salesforce extends Service {
    File_Upload_Setting__mdt salesforceSetting;
    
    
    public Service_Salesforce(File_Upload_Setting__mdt settings)
    {
        salesforceSetting = settings;
        ServiceName= 'Salesforce';
    }
    
    
    public override file upload(File file) {
        System.debug('Salesforce upload '+file.FileName);
        //List<External_File__c> lstextfile;
        Blob fileContents;
        if(file.file != null){
            fileContents = EncodingUtil.base64Decode(file.file);
            ContentVersion version =  generateNewContentVersionFile(file.FileName, file.folder+file.FileName, fileContents);
            file.versionId = version.id;
        }
        if(file.fileURL!=null){
            string[] urlElements = file.fileURL.split('&');

            if(urlElements!= null && urlElements.size()>1){
                string[] ids =  urlElements[1].split('=');
                if(ids!= null && ids.size()>0){
                    system.debug('ID:' + ids[1]);
                    file.versionId = ids[1];
                }
            }
        }
        if(file.versionId != null){
            ContentVersion version =  [SELECT ContentDocumentId,Title FROM ContentVersion WHERE id = :file.versionId];
            
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = version.ContentDocumentId;
            for(String objectId: file.objectIds)
                cdl.LinkedEntityId = objectId;
            cdl.ShareType = 'V';
            insert cdl;
            
            ContentDistribution distribution = new ContentDistribution();
            distribution.ContentVersionId  = version.Id;
            if(file.FileName == null){
               // lstextfile = [SELECT id from External_File__c limit 1];
                distribution.name = version.Title;
            }
            else{
                //lstextfile = [SELECT id from External_File__c limit 1];
                distribution.name = file.FileName;
            }
            
            for(String objectId: file.objectIds)
                distribution.RelatedRecordId = objectId;
            insert distribution;
              //added below lines for  testing purpose
        
         //lstextfile = [SELECT id from External_File__c limit 1];
            //map content document link id as external id
            file.externalID = version.ContentDocumentId;  
            // lstextfile = [SELECT id from External_File__c limit 1];
            if(file.fileURL == null){
                file.fileURL = getURL(distribution.id,version.id);  
            }
                  
        }

        if(String.isBlank(file.fileURL)){
            throw new UploadException('Failed to Upload');
        }
        return file;
    }
    
    public static String getURL(Id distributionId, Id versionId){
         //added below lines for  testing purpose
         List<External_File__c> lstextfile;
         lstextfile = [SELECT id from External_File__c limit 1];
        list<ContentDistribution> distributions = [SELECT id ,DistributionPublicUrl FROM ContentDistribution WHERE id = :distributionId LIMIT 1];
            String endpeice = distributions[0].DistributionPublicUrl.substring(distributions[0].DistributionPublicUrl.indexOf('/a/'),distributions[0].DistributionPublicUrl.length());
            String frontPeice = distributions[0].DistributionPublicUrl.substring(0,distributions[0].DistributionPublicUrl.indexOf('.com')+4);
            return frontPeice + '/sfc/dist/version/download/?oid=' + UserInfo.getOrganizationId() + '&ids=' + versionId + '&d=' + endpeice;
    }
    
    
    
    public static ContentVersion generateNewContentVersionFile(String title, String fileName, Blob blobData) {
        ContentVersion cont = new ContentVersion();
        cont.Title = title;
        cont.PathOnClient = fileName;
        cont.VersionData = blobData;
        cont.Origin = 'H';
        insert cont;
        
        return cont;
    }
    
    /*public static FeedItem generatePostWithRelatedDocument(Id parent, Id contentVersionId) {
FeedItem elm = new FeedItem(Body = 'Post with related document body', ParentId = parent, RelatedRecordId = contentVersionId, Type = 'ContentPost');
insert elm;
return elm;
}*/
    
    
}