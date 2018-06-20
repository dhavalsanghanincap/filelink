/*
 * Block comments with details of changes
 */
Global class Generic_Server_Upload_Controller
{
    Global String fileBody { get; set; }
    public String contentType { get; set; }
    Global String fileName { get; set; }
    public External_File_Relationship__c efrRecord{get;set;}
    
    public string dispresp{get;set;}
    public string pictureurl{get;set;}
    Global id objectId{get;set;}

    public Generic_Server_Upload_Controller(){
        
    }
    
    @RemoteAction
    Global static String attachFile2(String fileBody, String fileName, String objectId, list<String> tags){
        return Generic_Server_Upload_Controller.attachFile2(fileBody, fileName, objectId, tags, '');
    }

    @RemoteAction
    global static String attachFile2(String fileBody, String fileName, String objectId, List<String> tags, String mimeType) {
        File file = new File();
        file.fileName = fileName.replace('C:\\fakepath\\','');
        if(fileBody != null && fileBody.contains('base64,')){//this is more of a hack and likely a better way of doing this but I cant find it
            file.file = fileBody.substringAfter('base64,');
        }else if(fileBody != null){
            file.file = EncodingUtil.base64Encode(Blob.valueOf(fileBody));
        }
        file.folder = '';
        System.debug(tags);
        if(tags != null && tags.size() != 0){
            file.tags = tags;
        }
        file.mimeType = String.isNotBlank(mimeType) ? mimeType : '';
        file.objectIds.add(objectId);
        Service  Service = (Service)Factory_Service.createDefaultService();
        External_File__c extFile = Service.UploadFile(file);

        //return file.fileURL;
        return JSON.serialize(extFile);
    }
    
    @RemoteAction
    global static String attachFile3(String VersionId, String fileName, String objectId, List<String> tags, String mimeType) {
        File file = new File();
        file.fileName = fileName.replace('C:\\fakepath\\','');
        file.folder = '';
        System.debug(tags);
        if(tags != null && tags.size() != 0){
            file.tags = tags;
        }
        file.mimeType = String.isNotBlank(mimeType) ? mimeType : '';
        file.objectIds.add(objectId);
        file.VersionId = VersionId;
        Service  Service = (Service)Factory_Service.createDefaultService();
        External_File__c extFile = Service.UploadFile(file);

        //return file.fileURL;
        return JSON.serialize(extFile);
    }
}