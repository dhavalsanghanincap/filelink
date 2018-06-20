@isTest
global class Test_Mock_Cloudinary implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"public_id":"Test File","URL":"TEST.COM"}');
        res.setStatusCode(200);
        return res;
    }
}