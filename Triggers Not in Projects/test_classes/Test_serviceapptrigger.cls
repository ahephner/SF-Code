@isTest
private class Test_serviceapptrigger {
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

	@isTest
    static  void testAppointment(){
        //needed for pricebook 
        Id pricebookId = Test.getStandardPricebookId();
        //dates we want trigger to over write here
        datetime SD = datetime.newInstance(2019, 1, 15, 12, 30, 0);
        datetime ED = datetime.newInstance(2019, 1, 16, 12, 30, 0);
        //required dates for wo and sa
        datetime SASD = datetime.newInstance(2019, 1, 14, 12, 30, 0);
        datetime SAED = datetime.newInstance(2019, 1, 17, 12, 30, 0);
        datetime dd = datetime.newInstance(2019, 1, 19, 12, 30, 0);
        //dates to cause trip trigger 
        datetime schstart = datetime.newInstance(2019, 1, 14, 12, 30, 0);
        datetime schend = datetime.newInstance(2019, 1, 18, 12, 30, 0);
        
        Account cust = new Account(name='Test123456', type= 'Customer', Customer_Name__c = 'Test Customer 123456');
    	Contact c = new Contact(lastname= 'something', AccountId = cust.id );
 		User u1 = [SELECT Id FROM User WHERE Lastname like 'Test%'];
		insert cust;
        insert c; 
        //create workorder
       WorkOrder wo = new WorkOrder(ContactId = c.id, Area_Manager__c = u1.id, Pricebook2Id = pricebookID, StartDate = Sd, EndDate = ED); 
        insert wo; 
       serviceappointment sa = new serviceappointment(EarliestStartTime= SASD, DueDate=DD,Status='None', ParentRecordId = wo.id);
        serviceappointment sap = new serviceappointment(EarliestStartTime= SASD, DueDate=DD,Status='None', ParentRecordId = wo.id);
        insert sa; 
        insert sap; 
        
        Test.startTest();
        sa.SchedStartTime = schstart;
        sa.SchedEndTime = ED; 
        upsert sa; 
        sap.SchedStartTime = schend;
        sap.SchedEndTime = DD;
        upsert sap; 
        Test.stopTest();
        system.debug(wo);
        
        
        
    }
}