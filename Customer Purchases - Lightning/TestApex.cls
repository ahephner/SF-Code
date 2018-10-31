@isTest
public class CustomerProductsTest {
	
    public static testMethod void testSearch(){
        Sales_Doc_Detail__c testSale = new Sales_Doc_Detail__c();
        testSale.name = 'Test';
        testSale.sales_document__c = 'Test Doc';
        testSale.Product__c = 'FMC1030-96oz';
        
        insert testSale;
        
        //error here
        CustomerProducts testCont = new CustomerProducts();
        List<Sales_Doc_Detail__c> testC = testCont.getProducts();
        
        system.assert(testC != null);
    }
}