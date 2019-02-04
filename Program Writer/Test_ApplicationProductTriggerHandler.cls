@isTest
private class Test_ApplicationProductTriggerHandler {

  static List<Product__c> products = new List<Product__c>();
  static Area__c area = new Area__c();

  static {

    // insert some products
    Product__c r1 = new Product__c(Product_Name__c='Product 1');
    Product__c r2 = new Product__c(Product_Name__c='Product 2');
    Product__c r3 = new Product__c(Product_Name__c='Product 3');
    Product__c r4 = new Product__c(Product_Name__c='Product 4 is a product that purposely has a really really long Product name that would cause the total length of the string to be longer than 255 unless we used the new rules and annotated it at this point blah blah blah blah blah');
    products.add(r1);
    products.add(r2);
    products.add(r3);
    products.add(r4);
    insert products;
      
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

  }

  static testMethod void testInsertRecords() {

    List<Application__c> apps = new List<Application__c>();
    List<Application_Product__c> appProducts = new List<Application_Product__c>();
      
    // insert some applications
    Application__c a1 = new Application__c(name='Spring Test App 1');
    a1.Area__c = area.Id;
    Application__c a2 = new Application__c(name='Spring Test App 2');
    a2.Area__c = area.Id;
    apps.add(a1);
    apps.add(a2);
    insert apps;

    Test.startTest();

      appProducts.add(new Application_Product__c(Application__c=a1.Id, Product__c=products.get(0).Id));
      appProducts.add(new Application_Product__c(Application__c=a2.Id, Product__c=products.get(1).Id));
      appProducts.add(new Application_Product__c(Application__c=a1.Id, Product__c=products.get(2).Id));
      appProducts.add(new Application_Product__c(Application__c=a2.Id, Product__c=products.get(3).Id));

      insert appProducts;

    Test.stopTest();

    // since async, check for the accounts AFTER tests stop
    List<Application__c> updatedApps = [select id, name, Product_List__c from Application__c where id IN :apps];
    System.assertEquals('Product 1, Product 3',updatedApps.get(0).Product_List__c);
    System.assertEquals('Product 2...',updatedApps.get(1).Product_List__c);

  }

  static testMethod void testDeleteRecords() {

    List<Application__c> apps = new List<Application__c>();
    List<Application_Product__c> appProducts = new List<Application_Product__c>();

    // insert an application
    Application__c a1 = new Application__c(name='Spring Test App 1');
    a1.Area__c = area.Id;
    apps.add(a1);
    insert apps;

    Test.startTest();

      appProducts.add(new Application_Product__c(Application__c=a1.Id, Product__c=products.get(0).Id));
      appProducts.add(new Application_Product__c(Application__c=a1.Id, Product__c=products.get(1).Id));
      appProducts.add(new Application_Product__c(Application__c=a1.Id, Product__c=products.get(2).Id));
      appProducts.add(new Application_Product__c(Application__c=a1.Id, Product__c=products.get(3).Id));

      insert appProducts;

      // now delete a record
      delete appProducts.get(3);

    Test.stopTest();

    List<Application__c> updatedApps = [select id, name, Product_List__c from Application__c where id IN :apps];
    System.assertEquals('Product 1, Product 2, Product 3',updatedApps.get(0).Product_List__c);

  }

}