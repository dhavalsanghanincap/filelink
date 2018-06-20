/**
* @author 
* @date 
* @group 
* @group-content
* @description 
*/
global class FileLink_Helper {

    private static String JSON_POSTFIX = '.json';
    private static String JSON_MEDIATYPE = 'application/json';
    private static String ACCEPTS_HEADER = 'Accept';
    private static map<string,string> objectRelationshipFieldMap = new map<String,String>{'FileLInk__External_File_Relationship__c'=>'FileLInk__Object_ID__c'};
    private Static map<String,String> serviceNameRelationshipObjectMap = new map<String,String>{'Cloudinary'=>'FileLInk__External_File_Relationship__c'};
    /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    global static String getStringBodyParam(String param) {
        Map<String, Object> params = getRequestBody();
        return params.containsKey(param) ? String.valueOf(params.get(param)) : null;
    }
    
    /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    global static Map<String, Object> getRequestBody() {
        String body = RestContext.request.requestBody == null ? '{}' : RestContext.request.requestBody.toString();
        
        if(String.isBlank(body)) {
            body = '{}';
        } 
        return (Map<String, Object>) JSON.deserializeUntyped(body);
    }

    /**
    * @description Method to get related  
    * @param 
    * @param 
    * @return 
    * @example
    */
    /*public static void removeFileRelationshipRecords(map<id,sObject> oldMap){
        //1. Get default service
        Service defaultService = Factory_Service.createDefaultService();

        //2. Get the record from parallel object from which we will need to delete the relationship
        getRelatedRelationshipRecordfromSalesforce(oldMap,defaultService.ServiceName);
    }*/

    /**
    * @description Method to get related file link relationship record 
    * @param 
    * @param 
    * @return 
    * @example
    */
    /*public static list<SObject> getRelatedRelationshipRecordfromSalesforce(map<id,sObject> oldMap,String serviceName){
        String sobjectName ; 
        String whereClause ; 
        if(serviceNameRelationshipObjectMap != null && serviceNameRelationshipObjectMap.get(serviceName) != null){
            sobjectName = serviceNameRelationshipObjectMap.get(serviceName);
            if(objectRelationshipFieldMap != null && objectRelationshipFieldMap.get(sobjectName) != null){
                whereClause = ' ' + objectRelationshipFieldMap.get(sobjectName) +' in :oldMap.keyset()';
            }
        }
        system.debug('===>'+whereClause);
        return Database.query(getAllFieldsSOQL(sobjectName,whereClause));
    }*/

    /**
    * @description Method to get related file link relationship record 
    * @param 
    * @param 
    * @return 
    * @example Method to query all fields of object and create dynamic query
    */
    //
    /*private static String getAllFieldsSOQL(String objectName , String whereClause){
        String query;
         
            String selects = '';
             
            // Get a map of field name and field token
            Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
            list<string> selectFields = new list<string>();
             
            if (fMap != null){
                for (Schema.SObjectField ft : fMap.values()){ // loop through all field tokens (ft)
                    Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
                        selectFields.add(fd.getName());
                }
            }
             
            if (!selectFields.isEmpty()){
                for (string s:selectFields){
                    selects += s + ',';
                }
                if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
                 
            }
            query = 'SELECT ' + selects + ' FROM ' + objectName;
            if(whereClause != null) {
                query = query + ' where '+whereClause;
            }
        
        return query;
         
    }*/
    
    /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    /*global static Boolean getTriggerEnabled(String triggerObject) 
    {
        triggerObject = triggerObject.replace('__c', '');
        return getFeatureEnabled(triggerObject);
    }*/
    
    /**
    * @description 
    * @param 
    * @param 
    * @return 
    * @example
    */
    /*static Map<String, Boolean> features = null;
    global static Boolean getFeatureEnabled(String featureName) 
    {
        if(features == null)
        {
            features = new Map<String, Boolean>();
            for(FileLink_Trigger__mdt feature :[SELECT Id, DeveloperName, Enabled__c FROM FileLink_Trigger__mdt])
            {
                features.put(feature.DeveloperName, feature.Enabled__c);
            }
                
        }
        Boolean feature = features.get(featureName);
        
        if (feature != null) 
        {
            return feature;
        } 
        return false;
    }*/
}