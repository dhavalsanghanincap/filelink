/*
 * Block comments with details of changes
 */
trigger EFR_Trigger on FileLInk__External_File_Relationship__c (before insert,before update)
{
	//this makes sure we have a 18 character ID
    for (FileLInk__External_File_Relationship__c oli : Trigger.new){
        string s = oli.Object_ID__c;
        try{
            ID sID = s;
            oli.Object_ID__c = String.valueof(sID);
        } catch (System.StringException e){
        }
    }
}