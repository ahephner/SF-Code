@isTest
private class CustomerProductsTest {
	//Because doc_date__c is not writeable i am just testing that there is a product in the system to query 
	//against. We require a doc date well before sf and since this a simple query search i think this test is enough
    static testMethod void testSearch(){
        //get record type
        ID recordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        Account acct = new Account(); 
        acct.name = '509-Test Comp';
        acct.Customer_Name__c = 'New Company';
        acct.Customer__c = '1010';
        acct.RecordTypeId = recordType;
        insert acct;

        //create product
        Product__c prod = new Product__c(Product_Name__c='Something', Name='123'); 
        insert prod; 

        
        //Create Sales Doc
        Sales_Document__c sd = new Sales_Document__c();
        sd.name = 'test from sf';
        sd.sales_Doc_num__c = '454';
        //get new account recordid
        sd.Customer__c = acct.id;
        sd.Doc_Type__c = 'Invoice';
        
        insert sd; 
        
        Sales_Doc_Detail__c testSale = new Sales_Doc_Detail__c();
        testSale.name = 'Test';
        testSale.sales_document__c = sd.ID;
        testSale.Product__c = prod.ID;
        
        insert testSale;
        
     List<String> custnum = new List<String>();
				custnum.add('1010');
        
        String resultOne; 
        
        System.Test.startTest();
        for(Sales_doc_Detail__c check: [Select ID, name, Doc_Date__c from Sales_Doc_Detail__c where Customer__c LIKE: custnum]){
            resultOne = check.name; 
        }
        
       system.Test.stopTest(); 
        system.assertEquals('Test',resultOne);
         system.assert(CustomerProducts.getProducts(custnum).isempty());
    } 
        static testMethod void testSearchTwo(){
            ID recordType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        Account acct = new Account(); 
        acct.name = '23-Test Comp';
        acct.Customer_Name__c = 'New Company 2';
        acct.Customer__c = '10';
        acct.RecordTypeId = recordType;
        insert acct;

        //create product
        Product__c prod = new Product__c(Product_Name__c='Something', Name='321'); 
        insert prod; 

        
        //Create Sales Doc
        Sales_Document__c sd = new Sales_Document__c();
        sd.name = 'sf';
        sd.sales_Doc_num__c = '45';
        //get new account recordid
        sd.Customer__c = acct.id;
        sd.Doc_Type__c = 'Invoice';
        
        insert sd; 
        
        Sales_Doc_Detail__c testSale = new Sales_Doc_Detail__c();
        testSale.name = 'Test2';
        testSale.sales_document__c = sd.ID;
        testSale.Product__c = prod.ID;
        
        insert testSale;
        
 		 List<String> custnum = new List<String>();
				custnum.add('10');     
        
            String result; 
        System.Test.startTest();
          for(Sales_doc_Detail__c check: [Select ID, name, Doc_Date__c from Sales_Doc_Detail__c where Customer__c LIKE: custnum]){
            result = check.name;
        }
        
       system.Test.stopTest();
            system.assert(CustomerProducts.twoYears(custnum).isempty());
            system.assertEquals('Test2',result);
        }
}