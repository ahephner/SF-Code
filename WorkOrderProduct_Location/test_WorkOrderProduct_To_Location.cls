@isTest
private class test_WorkOrderProduct_To_Location {
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
    static void test_WorkOrderProduct_To_Location(){
	//pricebook
	Id pricebookId = Test.getStandardPricebookId();
	//product
	product2 prod = new product2(name ='product', IsActive= True); 
        insert prod;
    product2 prod2 = new product2(name ='current', IsActive= True); 
        insert prod2;
	//pricebook entry
	PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=prod.id,
                                                 unitprice=4, IsActive = True, UseStandardPrice=False);
    PricebookEntry pbe2 = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=prod2.id,
                                                 unitprice=5, IsActive = True, UseStandardPrice=False);    
        insert pbe;
        insert pbe2;
     //Account 
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.Customer_Name__c = 'Test Customer 123456';
        	insert cust;
    //user -> area manager on w.o. 
    User u1 = [SELECT Id FROM User WHERE Lastname like 'Test%'];

	//contact
	Contact c = new Contact(lastname= 'something', AccountId = cust.id );
        insert c;
	//workorder
	 WorkOrder wo = new WorkOrder(ContactId = c.id, Area_Manager__c = u1.id, Pricebook2Id = pricebookID); 
        insert wo;
	//workorderline items
	//location holds inventory = true,
	Schema.location l =new Schema.location(name='testLocation', locationType='Site', isInventoryLocation=True);
        insert l; 
         
	//productitems
    }
}