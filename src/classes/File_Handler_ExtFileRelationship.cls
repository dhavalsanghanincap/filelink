/**
* @author Vrajesh Sheth
* @date 12/13/2017
* @group 
* @group-content
* @description Handler class for externalFile relationship object
*/
public class File_Handler_ExtFileRelationship extends File_Handler {
    static boolean triggerIsRunningAfter = false;

     /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    public override void mainEntry(String triggerObject,
                                   Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate,
                                   Boolean isDelete, Boolean isUndelete, Boolean isExecuting, list<SObject> newList,
                                   map<Id,SObject> newMap, list<SObject> oldList, map<Id,SObject> oldMap) {
        if(trigger.isBefore && trigger.isDelete){
            
            //FileLink_Helper.removeFileRelationshipRecords(oldMap);
        }
                                   }
    /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    public override void  inProgressEntry(String triggerObject,
                                          Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate,
                                          Boolean isDelete, Boolean isUndelete, Boolean isExecuting, list<SObject> newList,
                                          map<Id,SObject> newMap, list<SObject> oldList, map<Id,SObject> oldMap) {
                                              
         mainEntry( triggerObject,
                                    isBefore,  isAfter,  isInsert,  isUpdate,
                                    isDelete,  isUndelete,  isExecuting,  newList,
                                    newMap,  oldList,  oldMap);
        
    }
}