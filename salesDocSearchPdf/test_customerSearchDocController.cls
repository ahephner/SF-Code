@isTest
public class test_customerSearchDocController {
    static testMethod void test_customerSearchDocController (){
        PageReference pref = Page.customerSalesDocsLightPDF;         
        Test.setCurrentPage(pref);
        
        //account
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.RecordTypeId = '01241000001Dy64AAC';
        cust.Customer_Name__c = 'Test Customer 123456';
        	insert cust;
        //contact
        contact person = new contact(lastname = 'test', AccountId = cust.Id);
        insert person; 
        //date and pricebook don't know if you need it just incase 
        Date myDate = Date.newInstance(2040, 1, 4);
        Date startdate = Date.newInstance(2040, 1, 3);
        Id pricebookId = Test.getStandardPricebookId();
        //sales doc
        Sales_Document__c head = new Sales_Document__c(name = 'test name', customer__c = cust.id, Doc_Type__c = 'Invoice', 
                                                       Sales_Doc_Num__c = '12345', Doc_Date__c = myDate );
	
        insert head;
        //insert products 
        product__c p = new product__c(Name='xyz', Product_Name__c = 'product', Active__c=True);
        //product__c pr = new product__c(Name='jdt-12', ProductCode =  'xyz');
        insert p;
       // insert pr; 
        
    	//doc detail
        Sales_Doc_Detail__c detail =  new Sales_Doc_Detail__c(name='test', Sales_Document__c=head.id, Product__c = p.Id, 
                                                              Quantity__c=1, Unit_Price__c=1);
         insert detail;
        
        Test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cust);
        customerSearchDocController ext = new customerSearchDocController(sc);
        
        list<Sales_Document__c> product = ext.head(startDate, myDate); 
        system.assertNotEquals(product, null);
       	pagereference np = ext.getsearch();
        //system.debug(np);
        
        
        Test.stopTest(); 
        
    
    }
}