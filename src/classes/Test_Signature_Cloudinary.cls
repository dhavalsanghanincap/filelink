@isTest
public class Test_Signature_Cloudinary
{
    static testMethod void Test_Signature_Cloudinary()
    {
        Signature_Cloudinary sign = new Signature_Cloudinary([select id,API_Key__c,Private_Key__c,Config_JSON__c from File_Upload_Setting__mdt where Service__c = 'Cloudinary' limit 1]);
        Map<String,Object> parametersToSign = new Map<String,Object>();
        parametersToSign.put('test','test');
        System.assertEquals(sign.getSignature(parametersToSign), sign.getSignature('test=test'));
        System.assert(String.isNotBlank(sign.getSignature(parametersToSign)));
    }
}