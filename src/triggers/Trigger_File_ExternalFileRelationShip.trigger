trigger Trigger_File_ExternalFileRelationShip on FileLInk__External_File_Relationship__c (after delete, after insert, after undelete, after update, before delete, before insert, before update)  {
    File_TriggerDispatcher.callHandler('External_File_Relationship__c', trigger.isBefore, trigger.isAfter, trigger.isInsert, trigger.isUpdate,
                                  trigger.isDelete, trigger.isUndelete, trigger.isExecuting, trigger.new, trigger.newMap, trigger.old,
                                  trigger.oldMap);
}