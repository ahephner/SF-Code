@isTest
private class test_updateContactFromUser {
	@testSetup
    static void setUp(){
        id rid = [select id from recordtype where description like 'Customer Account'].id;
        id crId = [select id from recordtype where description like '%Customer Contact%'].id; 
        Account cust = new Account();
        cust.name = 'Golf Course';
        cust.RecordTypeId = rid;
        cust.Customer_Name__c = '123-Golf Course';
       insert cust; 
        
        Contact person = new Contact(); 
        person.lastname = 'Test';
        person.AccountId = cust.Id; 
        person.RecordTypeId = crId; 
       insert person; 
    }
    @isTest
    static void updateContactFromUser(){
          //for update contact
        id crId2 = [select id from recordtype where description like '%Customer Contact%'].id;
        //query contact to assign to user
        Id cId = [select id from contact where lastname = 'Test'].id; 
        system.debug('cId '+ cId);
        //create user
 		//get a user profile that is a community member so we can set the user to have access 
        Profile proId = [SELECT Id FROM Profile WHERE Name = 'ATS Connect - Customer Community Login User'];
        
 		User u1 = new User(
         ProfileId = proId.id,
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
    );
        insert u1;
        
        test.startTest();
        	User og = [select id, lastname, contactId, Contact.AccountID from user where CompanyName = 'TEST' ];
        	system.debug(og);
        	og.LastName = 'Cutler';
		   	update og;
        test.stopTest();
        
        //verify
         contact j = [select id from contact where lastname ='Cutler'];
         system.assertNotEquals(null, j.Id); 
    }
}