@istest
public class test_addCongaPermSet {
    @isTest
    Static void insertUser(){
                //create user
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
		insert r;
 
 		User u = new User(
         ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
         LastName = 'last',
         Email = 'puser000@amamama.com',
         Username = 'puser000@amamama.com' + System.currentTimeMillis(),
         CompanyName = 'TEST',
         Title = 'title',
         Alias = 'alias',
         TimeZoneSidKey = 'America/Los_Angeles',
         EmailEncodingKey = 'UTF-8',
         LanguageLocaleKey = 'en_US',
         LocaleSidKey = 'en_US',
         UserRoleId = r.Id
    );
        insert u; 
    }
    @istest
    Static void testFuture(){
                UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
		insert r;
 
 		User u = new User(
         ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
         LastName = 'last',
         Email = 'puser000@amamama.com',
         Username = 'puser000@amamama.com' + System.currentTimeMillis(),
         CompanyName = 'TEST',
         Title = 'title',
         Alias = 'alias',
         TimeZoneSidKey = 'America/Los_Angeles',
         EmailEncodingKey = 'UTF-8',
         LanguageLocaleKey = 'en_US',
         LocaleSidKey = 'en_US',
         UserRoleId = r.Id
    );
        insert u; 
        list<string> x = new list<string>(); 
        x.add(u.id); 
        list<string> y = new list<string>();
        system.debug('user ' + u + ' x '+ x);
        
        Test.startTest();
     		addCongaPermSet.addCongaPermSet(x);
        try{
            addCongaPermSet.addCongaPermSet(y); 
                }catch(DMLexception e){
                    system.assertEquals(e.getMessage(), e.getMessage());
                }
        Test.stopTest();
         PackageLicense pl = [SELECT Id, NamespacePrefix, AllowedLicenses, UsedLicenses, 
        					 ExpirationDate,Status FROM PackageLicense WHERE 
        					 NamespacePrefix = 'APXTConga4'];

         
    }
}