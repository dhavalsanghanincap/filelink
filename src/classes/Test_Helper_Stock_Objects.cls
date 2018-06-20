public class Test_Helper_Stock_Objects
{
    public static File getStockFile(){
        File file = new File();
        file.file = '';
        file.folder = 'test';
        file.FileName = 'test file';
        Account account = getStockAccount();
        file.objectIds.add(account.id);
        file.tags.add('Close');
		return file;
    }

    public static Account getStockAccount(){
        Account account = new Account();
        account.name = 'Test Account';
        insert account;
        return account;
    }

     public static File getStockFileWithURL(){
        File file = new File();
        file.fileURL = 'www.test.com';
        file.folder = 'test';
        file.FileName = 'test file';
        Account account = getStockAccount();
        file.objectIds.add(account.id);
        file.tags.add('Close');
		return file;
    }
}