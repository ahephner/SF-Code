//Configured for ATS Connect Customer Community - May 2020
@isTest
private class CommunityControllerTest {
//create data----Note because we are also creating a user later need to insert account here
	@testSetup
    static void setUp(){
        string rid = [select id from recordtype where description like 'Customer Account'].id;
        Account cust = new Account();
        cust.name = 'Golf Course';
        cust.RecordTypeId = rid;
        cust.Customer_Name__c = '123-Golf Course';
       insert cust; 
        
        Contact person = new Contact(); 
        person.lastname = 'Test';
        person.AccountId = cust.Id; 
       insert person; 
    }
    @isTest
    static void getLoggedInUserTest(){
        //query account for assert equals
        Id acc = [select id from account where customer_name__c = '123-Golf Course'].id;
        //query contact to assign to user
        Id cId = [select id from contact where lastname = 'Test'].id; 
        
        //create 
 		//get a user profile that is a community member so we can set the user to have access 
        Profile proId = [SELECT Id FROM Profile WHERE Name = 'ATS Connect - Customer Community Login User'];
        
 		User u1 = new User(
         ProfileId = proId.id,
        // UserRoleId = roleId.id,
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
         contactId = cId
        // IsPortalEnabled = True
    );
        insert u1;
        
        system.runAs(u1){
            test.startTest();
            // ApexPages.StandardController sc = new ApexPages.StandardController(cust);
            User rUser =  CommunityController.getLoggedInUser();
            test.stopTest();
      		//make sure contact points to right account 
            system.assertEquals(acc, rUser.Contact.AccountID); 
        }
    }
}