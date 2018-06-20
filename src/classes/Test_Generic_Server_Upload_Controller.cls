@isTest
public class Test_Generic_Server_Upload_Controller {

    @isTest
    public static void test()
    {
        Generic_Server_Upload_Controller controller = new Generic_Server_Upload_Controller();
        String test = controller.fileBody;
         test = controller.contentType;
         test = controller.fileName;
         //test = controller.efrRecord;
        
         test = controller.dispresp;
         test = controller.pictureurl;
         test = controller.objectId;
    }
    
    @isTest
    public static void attachFile2()
    {
        //insert case
        Case objCase = new Case();
        insert objCase;
        
        List<String> tags = new List<String>();
        tags.add('Create');
        Generic_Server_Upload_Controller.attachFile2('Test Body','test.jpg',objCase.Id,tags);
    }
}