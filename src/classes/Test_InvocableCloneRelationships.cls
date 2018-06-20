@isTest
public class Test_InvocableCloneRelationships {

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
        
        list<External_File_Relationship__c> relationships = External_File_Relationship.getExternalFileRelationship(cas.Id);
        
        System.assertEquals(relationships.size(), 1);
        
		InvocableCloneRelationships.input input = new InvocableCloneRelationships.input();
        input.fromId = cas.id;
        input.toId = cas2.id;
        list<InvocableCloneRelationships.input> inputs = new list<InvocableCloneRelationships.input>();
        inputs.add(input);
        InvocableCloneRelationships.UpsertServiceActivity(inputs);
        
        relationships = External_File_Relationship.getExternalFileRelationship(cas2.Id);
        
        System.assertEquals(relationships.size(), 1);
    }
}