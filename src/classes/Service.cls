/*
 * Block comments with details of changes
 */
global virtual class Service
{
    global String ServiceName;
    public Service()
    {

    }

    public virtual void createExternalFileRelationship(String URL, String ObjectId){
    }

    global virtual External_File__c UploadFile(File file){
        System.debug('FileName '+file.FileName);
        file = upload(file);
        return  fileUploaded(file.externalID, file.fileURL, file);
    }
    
    global virtual file upload(File file){
        return null;
    }

    global virtual List<External_File_Relationship__c> relateFile(External_File__c ef, List<String> objectIds, List<String> tags) {
    
        List<External_File_Relationship__c> efrs = new list<External_File_Relationship__c>();
        
        for(String objectId: objectIds){
            External_File_Relationship__c efr = new External_File_Relationship__c();
            efr.Object_ID__c = objectId;
            efr.External_File__c = ef.id;
            efr.Tags__c = tags != null ? String.join(tags, ';') : null;
            efrs.add(efr);
        }
        insert efrs;
        
        return efrs;
    }

    global virtual List<External_File_Relationship__c> relateFile(External_File__c ef, List<String> objectIds) {
        return relateFile(ef, objectIds, null);
    }
 
    global virtual External_File__c findFileByExternalId(String externalId) {
        List<External_File__c> files = [
            SELECT 
                Id, External_Id__c, Tags__c, (SELECT Id, Object_Id__c, Tags__c FROM FileLink__External_File_Relationships__r)
            FROM
                External_File__c
            WHERE
                External_Id__c = :externalId
        ];
        
        return files.size() > 0 ? files[0] : null;  
    }
 
    public virtual External_File__c fileUploaded(String externalID, String url, File f){
        //List<External_File__c> lstextfile;
         //lstextfile = [SELECT id from External_File__c limit 1];

        List<String> objectIds = f.objectIds;
        List<String> tags = f.tags;
    
        External_File__c ef = new External_File__c();
        ef.FileLInk__External_ID__c = externalId;
        ef.Public_URL__c = url;
        ef.Service__c = ServiceName;
        ef.Filename__c = f.fileName;
        ef.FileLInk__Mime_Type__c = f.mimeType;
        
        for(String tag : tags){
            if(ef.tags__C == null){
                ef.tags__C = tag;
            }else{
                ef.tags__C = ef.tags__C +';'+tag;
            }
        }
      //added below lines for testing purpose
         //f.localCommit = true; 
        
         //lstextfile = [SELECT id from External_File__c limit 1];
        //end here
        if(f.localCommit){
            insert ef;            
            relateFile(ef, f.objectIds);
        }
        //lstextfile = [SELECT id from External_File__c limit 1]; //added this line for testing purpose
        return ef;
    }

    public class UploadException extends Exception {}
}