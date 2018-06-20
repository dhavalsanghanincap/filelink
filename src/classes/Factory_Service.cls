/*
 * Block comments with details of changes
 */
global class Factory_Service
{
    global static Service createDefaultService()
    {
        File_Upload_Setting__mdt defaultSettings = [select id,API_Key__c,Private_Key__c,Config_JSON__c,Service__c from File_Upload_Setting__mdt where Is_Default__c = true limit 1];
        return createService(defaultSettings.Service__c);
    }

    global static Service createService(String ServiceName) 
    {
        if(ServiceName == 'Cloudinary'){
            File_Upload_Setting__mdt defaultSettings = [select id,API_Key__c,Private_Key__c,Config_JSON__c from File_Upload_Setting__mdt where Service__c = 'Cloudinary' limit 1];
            Service_Cloudinary cloudinary = new Service_Cloudinary(defaultSettings);
            return (Service)cloudinary;
        }else if(ServiceName == 'Salesforce Files'){
            File_Upload_Setting__mdt defaultSettings = [select id,API_Key__c,Private_Key__c,Config_JSON__c from File_Upload_Setting__mdt where Service__c = 'Salesforce Files' limit 1];
            Service_Salesforce salesforce = new Service_Salesforce(defaultSettings);
            return (Service)salesforce;
            
        }
        throw new ServiceFactoryException('Service '+ServiceName+' cannot be found');
        return null;
    }
    
    
    public static String getDefaultServiceName(){
        File_Upload_Setting__mdt defaultSettings = [select id,API_Key__c,Private_Key__c,Config_JSON__c,Service__c from File_Upload_Setting__mdt where Is_Default__c = true limit 1];
        return defaultSettings.Service__c;
    }
    
    
    public class ServiceFactoryException extends Exception {}
}