/*********
* @author Vrajesh Sheth
* @date 12/13/2017 
* @group 
* @group-content
* @description Common dispatcher class for all the triggers for Filelink package
*/
public with sharing class File_TriggerDispatcher  {

    //Variable to track current object for trigger execution. Used to restrict chain of case events while creating service request.
    public static String currentSObject;
    public static Map<String,File_Handler> activeHandlers = new Map<String,File_Handler>();
    public static File_Handler activeHandler;
    /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    public static void callHandler(String triggerObject,
        Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate,
        Boolean isDelete, Boolean isUndelete, Boolean isExecuting, list<SObject> newList,
        map<Id,SObject> newMap, list<SObject> oldList, map<Id,SObject> oldMap)
    {
        File_Handler tempHandler;
        
        //set currentSObject if not assigned already
        if(String.isBlank(File_TriggerDispatcher.currentSObject))
        {
            File_TriggerDispatcher.currentSObject = triggerObject;
        }
        
         tempHandler = activeHandlers.get(triggerObject);
            if (tempHandler != null) {
               /*tempHandler.inProgressEntry(triggerObject, 
                    isBefore, isAfter, isInsert, isUpdate, isDelete, isUndelete, 
                    isExecuting, newList, newMap, oldList, oldMap);*/
            }
            else {
                tempHandler = getinActiveHandlers().get(triggerObject);
                if(tempHandler != null){
                activeHandlers.put(triggerObject,tempHandler);
                /*tempHandler.mainEntry(triggerObject, 
                        isBefore, isAfter, isInsert, isUpdate, isDelete, isUndelete, 
                        isExecuting, newList, newMap, oldList, oldMap);*/
                }
            }
    }

    public static Map<String,File_Handler> getinActiveHandlers(){
        Map<String,File_Handler> inActiveHandlers = new Map<String,File_Handler>();
        
        inActiveHandlers = new Map<String,File_Handler>();
       
        		
        return inActiveHandlers;
    }
}