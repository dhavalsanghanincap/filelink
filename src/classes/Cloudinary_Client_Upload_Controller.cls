/*
 * Block comments with details of changes
 */
public class Cloudinary_Client_Upload_Controller
{
    public Signature_Cloudinary signature {get;set;}
    public Service_Cloudinary cloudinary {get;set;}
    public Cloudinary_Client_Upload_Controller()
    {
        cloudinary = (Service_Cloudinary)Factory_Service.createService('Cloudinary');
        this.signature = cloudinary.signature;
    }
    
    public string getPreset(){
        return cloudinary.getPreset();
    }
    
    
    public string getURL(){
        return cloudinary.getURL();
    }
}