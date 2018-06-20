global class InvocableCloneRelationships {

    @InvocableMethod(label='Upsert Service Activity' description='Upsert a Service Activity')
    global static list<Id>  UpsertServiceActivity(list<Input> inputs){
        list<External_File_Relationship__c> newRelationships = new list<External_File_Relationship__c>();
        
        for(Input input : inputs){
            list<External_File_Relationship__c> relationships = External_File_Relationship.getExternalFileRelationship(input.FromId);
            System.debug('input.FromId ' + input.FromId+ ' relationships '+relationships );
            for(External_File_Relationship__c relationship : relationships){
                External_File_Relationship__c newRelationship;
                newRelationship = relationship.clone();
                newRelationship.Object_ID__c = input.toId;
                newRelationships.add(newRelationship);
            }
        }
        
        insert newRelationships;
        System.debug(newRelationships);
        return new list<Id>();
    }
    
    global class Input{
        @InvocableVariable
        global String FromID;
        @InvocableVariable
        global String ToID;
    }
}