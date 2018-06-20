/*********
* @author Vrajesh Sheth    
* @date  12/313/2017 
* @group 
* @group-content
* @description Abstract class for all the trigger handlers
*/
public abstract class File_Handler {
    
    private boolean runAlready;
    /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    public virtual void run(String triggerObject,
                            Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate,
                            Boolean isDelete, Boolean isUndelete, Boolean isExecuting, list<SObject> newList,
                            map<Id,SObject> newMap, list<SObject> oldList, map<Id,SObject> oldMap){
                                if(runAlready){
                                    inProgressEntry(triggerObject, 
                                                    isBefore, isAfter, isInsert, isUpdate, isDelete, isUndelete, 
                                                    isExecuting, newList, newMap, oldList, oldMap);
                                }else{
                                    mainEntry(triggerObject, 
                                              isBefore, isAfter, isInsert, isUpdate, isDelete, isUndelete, 
                                              isExecuting, newList, newMap, oldList, oldMap);
                                    runAlready = true;
                                        }
                            }
    
        /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    public abstract void mainEntry(String triggerObject,
                                   Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate,
                                   Boolean isDelete, Boolean isUndelete, Boolean isExecuting, list<SObject> newList,
                                   map<Id,SObject> newMap, list<SObject> oldList, map<Id,SObject> oldMap);
    
        /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    public abstract void inProgressEntry(String triggerObject,
                                         Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate,
                                         Boolean isDelete, Boolean isUndelete, Boolean isExecuting, list<SObject> newList,
                                         map<Id,SObject> newMap, list<SObject> oldList, map<Id,SObject> oldMap);
    
}