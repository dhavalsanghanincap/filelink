/*
 * Block comments with details of changes
 */
public class Service_Cloudinary extends Service
{
    public Signature_Cloudinary signature {get;set;}
    File_Upload_Setting__mdt cloudinarySetting;
    public Json_Config config;
    public String folder { get; set; }

    public Service_Cloudinary(File_Upload_Setting__mdt settings)
    {
        cloudinarySetting = settings;
        this.signature = new Signature_Cloudinary(cloudinarySetting);
        this.config = (Json_Config)JSON.deserializeStrict(cloudinarySetting.Config_JSON__c,Json_Config.class);
        ServiceName= 'Cloudinary';
    }



    public String getTimeStamp(){
        return String.valueOf(System.NOW().getTime() / 1000);
    }

    public String getApiSecret(){
        return cloudinarySetting.Private_Key__c;
    }

    public String getAPIKey(){
        return cloudinarySetting.API_Key__c;
    }
    public String getCloudName(){
        return config.cloudName;
    }
    public String getPreset(){
        return config.preset;
    }

    public String getURL() {
        return 'https://api.cloudinary.com/v1_1/' + config.cloudName;
    }

    public String getSigned() {
        return signature.getSignature(getParams(this.folder));
    }

    public string getSigned(String folder){
        return signature.getSignature(getParams(folder));
    }
    
    public  Map<String,Object> getParams(String folder){
        Map<String,Object> params = new Map<String,Object>();
        params.put('timestamp',getTimeStamp());
        //params.put('unique_filename',false);
        //params.put('use_filename',true);
        //params.put('folder',folder);
        params.put('upload_preset',getPreset());
        return params;
    }
    
    private HttpResponse request(String endpoint, String method, String body) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(this.getURL() + endpoint);
        req.setMethod(method);
        
        if(body != null) {
            req.setBody(body);
        }
        
		System.debug('STDebug: HttpRequest:' + req);
		System.debug('STDebug: body:' + body);
        return h.send(req);
    }
    
    private HttpResponse uploadRawFile(File file) { 
        String fileString = EncodingUtil.urlEncode('data:image/png;base64,' + file.file, 'UTF-8');  
        
        String sig = signature.getSigendURL(getParams(String.isNotBlank(this.folder) ? this.folder : file.folder), false); 
         
        String finalBodyString = sig + '&file=' + fileString; 
        
        return request('/upload', 'POST', finalBodyString);
    }
    
    private HttpResponse uploadRemoteFile(File file) {
        String sig = signature.getSigendURL(getParams(String.isNotBlank(this.folder) ? this.folder : file.folder), false); 
         
        String finalBodyString = sig + '&file=' + file.fileUrl; 
         
        return request('/upload', 'POST', finalBodyString);
    }

    public override file upload(File file) {
        HttpResponse resp;
        
        
        if(file.file != null) {
            resp = uploadRawFile(file);
        }
    
        else if(file.fileURL != null) {
            resp = uploadRemoteFile(file);
        }
        
        
        if(resp == null) {
            throw new UploadException('No fileURL or file body set; unable to upload image to Cloudinary');
        }
        
        if(resp.getStatusCode() == 200){
            Json_Response response = getResponse(resp);
            file.fileURL = response.secure_url;
            file.externalID = response.public_id;
            return file;
        }else{
            throw new UploadException(resp.getStatusCode() + ' : ' + resp.getBody());
        }
         
    }

    private class Json_Config{
        public String cloudName;
        public String preset;
        public Json_Config(){
        }
    }
    
    private class Json_Response{
        public String url;
        public String public_id;
        public String secure_url;
    }
    
    public static Json_Response getResponse(HttpResponse res){
            JSONParser parser = JSON.createParser(res.getbody());
            Json_Response response = (Json_Response)parser.readValueAs(Json_Response.class);
            return response;
        }
}