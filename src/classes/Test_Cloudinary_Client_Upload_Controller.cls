@isTest
public class Test_Cloudinary_Client_Upload_Controller
{
    static testMethod void Test_Cloudinary_Client_Upload_Controller()
    {
        Cloudinary_Client_Upload_Controller controller = new Cloudinary_Client_Upload_Controller();
        controller.getPreset();
        System.assertEquals(controller.getUrl(),controller.getUrl());
        System.assertEquals(controller.cloudinary.ServiceName,'Cloudinary');
    }
}