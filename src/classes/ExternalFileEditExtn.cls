public with sharing class ExternalFileEditExtn {
    private String objectID;
    private String externalRelationShipID;
    public PageReference Cancel() {
        Pagereference pageref = new Pagereference('/'+objectID);
        pageref.setredirect(true);
        return pageref;
    }
    
    public Pagereference OnSave(){
        update externalFileRecord;
        update externalFileRelationRecord;
        Pagereference pageref = new Pagereference('/'+objectID);
        pageref.setredirect(true);
        return pageref;
    }

    public ExternalFileEditExtn() {
        objectID = ApexPages.currentPage().getParameters().get('objectID');
        //externalRelationShipID = ApexPages.currentPage().getParameters().get('externalRelationShipID');
        externalFileRelationRecord = [SELECT id, FileLInk__External_File__c, FileLInk__External_File__r.Is_Private__c ,Tags__c FROM FileLInk__External_File_Relationship__c WHERE id=:objectID];
        externalFileRecord = new FileLInk__External_File__c(id=externalFileRelationRecord.FileLInk__External_File__c,Is_Private__c = externalFileRelationRecord.FileLInk__External_File__r.Is_Private__c);
    }

    public FileLInk__External_File__c externalFileRecord{get;set;}
    public FileLInk__External_File_Relationship__c externalFileRelationRecord{get;set;}
    
    
    
}