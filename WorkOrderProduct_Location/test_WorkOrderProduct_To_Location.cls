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
    //location holds inventory = true,
	Schema.location l =new Schema.location(name='testLocation', locationType='Site', isInventoryLocation=True);
        insert l; 
         
	//productitems
	productitem pi = new productitem(Product2Id= prod2.id, QuantityOnHand=1 , locationID=l.id);
        insert pi;
        productitem pi1 = new productitem(Product2Id= prod.id, QuantityOnHand=1 , locationID=l.id);
        insert pi1;
    //map
    map<string, ProductItem> prodList = new map<string, ProductItem>();
         
	//workorder
	 WorkOrder wo = new WorkOrder(ContactId = c.id, Area_Manager__c = u1.id, Pricebook2Id = pricebookID); 
        insert wo;
	//workorderline items
	WorkOrderLineItem wop = new WorkOrderLineItem(WorkOrderId = wo.id, PricebookEntryId = pbe.id, Quantity=1, Product_Code__c = '123', Account__c = cust.Id);
    WorkOrderLineItem wop1 = new WorkOrderLineItem(WorkOrderId = wo.id, PricebookEntryId = pbe2.id,  Quantity=1, Product_Code__c = '321', Account__c = cust.Id);
        //here is the issue
        insert wop;
        insert wop1; 

    //standard controller
   ApexPages.StandardController con = new ApexPages.StandardController(wo); 
   //extension controller
    workOrderProductsToLocation ext = new workOrderProductsToLocation(con);
system.debug('product 2 ' +wop1);
        system.debug('item ' +pi);
   //start test
  Test.startTest();
        PageReference ref = ext.send(); 
        List<productitem> k = [select id,QuantityOnHand, Product2Id,Account_Name__c  from productitem ];
        List<workorderlineitem> w = [select id, product2id, quantity from workorderlineitem];
        System.assertNotEquals(k, null);
        system.debug('customer stuff ' +k);
        system.debug('wop '+w);
  Test.stopTest();
    }
}