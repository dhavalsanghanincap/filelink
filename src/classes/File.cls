global class File {
    global File() {

    }
    
    global String file;//base64 file
    global String folder;
    global String FileName;
    global String fileURL;
    global String versionId;
    global String externalID;
    global String mimeType;
    global list<String> objectIds = new list<String>();
    global list<String> tags = new list<String>();
    
    /*
        Should the file be commited to Salesforce after it's been uploaded?
        
        Defaults to true.
    */
    global Boolean localCommit = true;
}