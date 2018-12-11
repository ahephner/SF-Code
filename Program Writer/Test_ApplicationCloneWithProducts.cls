//88% on 12/11/19

@isTest
private class Test_ApplicationCloneWithProducts {
	@isTest
    static  void Test_ApplicationCloneWithProducts() {

       // setup a reference to the page the controller is expecting with the parameters
        PageReference pref = Page.ApplicationCloneWithProducts;
        Test.setCurrentPage(pref);

        // setup a new account
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;

        // create new program
        Program__c prog = new Program__c();
        prog.Name = 'Test Program 2018';
        prog.Account__c = cust.Id;
        insert prog;
        
        // create new area
        Area__c area = new Area__c();
        area.Name = 'Greens';
        area.Program__c = prog.Id;
        area.Area_Acres__c = 1000;
        insert area;

        // create new application
        Application__c app = new Application__c();
        app.Area__c = area.Id;
        app.Date__c = Date.newInstance(2020,01,01);
        app.Name = 'Spring Test App';
        app.Repeat__c = True;
        app.Weeks_Apart__c = 2; 
        app.Number_of_Apps__c = 1; 
        insert app;
        
        // create new product
        Product__c prod = new Product__c();
        prod.name = 'Test Product 1';
        prod.Product_Name__c = 'Test Product'; 
        prod.size__c = 128; 
        insert prod;

        // create a application product for the app
        Application_Product__c ap = new Application_Product__c();
        ap.Product__c = prod.id;
        ap.Application__c = app.id;
        ap.OZ_M__c = 20;
        insert ap;

        // Construct the standard controller
        ApexPages.StandardController con = new ApexPages.StandardController(app);

        // create the controller
        ApplicationCloneWithProducts_Controller ext = new ApplicationCloneWithProducts_Controller(con);

        // Switch to test context
        Test.startTest();

        // call the cloneWithItems method
        PageReference ref = ext.cloneWithItems();
        // create the matching page reference
        PageReference redir = new PageReference('/'+ext.newRecordId+'/e?retURL=%2F'+ext.newRecordId);
        system.debug(ext.newRecordId+ ' id here?');
		  //PageReference redir = new PageReference('/lightning/r/Area__c/'+app.Area__c+'/view?ws=%2Flightning%2Fr%2FProgram__c%2F'+app.Program_ID__c+'%2Fview'); 	
        // make sure the user is sent to the correct url
        //System.assertEquals(ref.getUrl(),redir.getUrl());

        // check that the new po was created successfully
        Application__c newApp = [select id from Application__c where id = :ext.newRecordId];
        System.assertNotEquals(newApp, null);
        // check that the line item was created
        List<Application_Product__c> newItems = [Select p.Id From Application_Product__c p where Application__c = :newApp.id];
        System.assertEquals(newItems.size(),1);

        // Switch back to runtime context
        Test.stopTest();

    }

}