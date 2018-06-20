public class External_File_Relationship 
{    
    public static list<External_File_Relationship__c> getExternalFileRelationship(id sobjectId)
    {
        return [select id,External_File__r.Is_Private__c, External_File__r.Filename__c, External_File__r.Mime_Type__c, Tags__c,External_File__c, CreatedBy.Name, CreatedDate, External_File__r.External_ID__c ,External_File__r.Public_URL__c from External_File_Relationship__c where Object_ID__c = :sobjectId and Object_ID__c != null and Deleted__c=false order by CreatedDate Desc];
    }
    
    /**
    * @description Method to mark external file relationship records as deleted 
    * @param Set<Id> recordIdSet
    * @return 
    * @example
    */
    public static void removeFileRelationship(Set<Id> recordIdSet)
    {
        //Fetch records
        List<FileLInk__External_File_Relationship__c> lstFileRel = [SELECT Id,FileLInk__Deleted__c FROM FileLInk__External_File_Relationship__c WHERE Id IN:recordIdSet];
        
        for(FileLInk__External_File_Relationship__c objFileRel : lstFileRel)
        {
            //set deleted flag
            objFileRel.FileLInk__Deleted__c = true;
        }
        
        Database.update(lstFileRel);
    }
}