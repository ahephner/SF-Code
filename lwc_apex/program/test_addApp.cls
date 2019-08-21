@isTest
private class test_addApp {
  static Area__c area = new Area__c();
  static Program__c prog = new Program__c();
  static Product__c r1 = new Product__c();
  static Product__c r2 = new Product__c();  
  static Application__c Application = new Application__c();
    static{
    //product 
     r1.Product_Name__c='Product 1';
     r1.Primary_Category__c = 'Chemicals';
     r1.Subcategory__c ='Chemicals-Herbicide';
     r1.Include_in_Programs__c = True;
     r1.Size__c = 1; 
     
     r2.Product_Name__c='Product 2';
     r2.Primary_Category__c = 'Chemicals';
     r2.Subcategory__c = 'Chemicals-Fungicide';
     r2.Include_in_Programs__c = True;   
     r2.Size__c = 2; 
     insert r1; 
     insert r2;    
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
    area.Name = 'Greens';
    area.Program__c = prog.Id;
    area.Area_Acres__c = 1000;
    insert area;
     
    Application.Name = 'test app';
    Application.Area__c = area.id;  
    insert Application;
    
    }
    
    @isTest
    static void testAddProducts(){
        list<application_product__c> apList = new list<application_product__c>(); 
        Application_Product__c ap1 = new Application_Product__c(Application__c=application.Id,Product__c = r1.Id, OZ_M__c = 1, Note__c ='');
        Application_Product__c ap2 = new Application_Product__c(Application__c=application.Id,Product__c = r2.Id, OZ_M__c = 2, Note__c ='');
        apList.add(ap1);
        apList.add(ap2);
        String myJSON = JSON.serialize(apList); 
        //system.debug('here is JSON *** ' +myJSON);
        Test.startTest(); 
        	list<Application_Product__c> prodList = addApp.addProducts(myJson);
        Test.stopTest(); 
    }
    @isTest
    static void testUpdateProducts(){
        
    }
}