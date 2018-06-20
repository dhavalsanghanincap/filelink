/*
 * Block comments with details of changes
 */
public class Signature_Cloudinary
{
    File_Upload_Setting__mdt cloudinarySetting;
    public String timeStamp ;

    public Signature_Cloudinary( File_Upload_Setting__mdt cloudinarySetting)
    {
        this.cloudinarySetting =  cloudinarySetting;

    }

    public String getApiSecret(){
        return cloudinarySetting.Private_Key__c;
    }

    public String getSignature(Map<String,Object> parametersToSign){
        String stringToSign = '';
        list<String> keys = new list<String>(parametersToSign.keySet());
        keys.sort();
        for(String key :keys){
            if(parametersToSign.get(key) != null && parametersToSign.get(key) != ''){
                stringToSign = stringToSign+key+'='+String.valueOf(parametersToSign.get(key))+'&';
            }
        }
        stringToSign = stringToSign.removeEnd('&');
        return getSignature(stringToSign);
    }

    public String getSigendURL(Map<String,Object> parametersToSign, boolean useAPISecret){
        String stringToSign = '';
        String stringURL = '';
        list<String> keys = new list<String>(parametersToSign.keySet());
        keys.sort();
        for(String key :keys){
            if(parametersToSign.get(key) != null && parametersToSign.get(key) != ''){
                stringToSign = stringToSign+key+'='+String.valueOf(parametersToSign.get(key))+'&';
                stringURL = stringURL+key+'='+EncodingUtil.urlEncode(String.valueOf(parametersToSign.get(key)), 'UTF-8')+'&';
            }
        }
        
        stringToSign = stringToSign.removeEnd('&');
        stringURL = stringURL.removeEnd('&');
        if(useAPISecret){
            stringToSign = stringToSign+getApiSecret();
            //stringURL = stringURL+getApiSecret();
        }

        return 'api_key='+cloudinarySetting.API_Key__c+'&'+stringURL+'&signature='+EncodingUtil.urlEncode(getSignature(stringToSign), 'UTF-8');
    }

    public String getSignature(String stringToSign){
        stringToSign = stringToSign+getApiSecret();
        Blob hash = Crypto.generateDigest('SHA1',Blob.valueOf(stringToSign));
        String hexDigest = EncodingUtil.convertToHex(hash);
        return hexDigest;
    }

}