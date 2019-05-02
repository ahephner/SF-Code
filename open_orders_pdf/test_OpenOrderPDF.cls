@isTest
public class test_OpenOrderPDF {
    static testMethod void test_OpenOrderPDF(){
        
        list<open_order__c> oplist = new list<open_order__c>();
        
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.RecordTypeId = '01241000001Dy64AAC'; 
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;
        
        Open_Order__c op = new open_order__c(Open_Doc__c = '1234', Customer__c = cust.Id, name='1234');
        oplist.add(op);
        
        insert oplist; 
        
        test.startTest();
        	 PageReference pageRef = Page.massEditOpenOrderNotes;
        	Test.setCurrentPage(pageRef);
        	ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(oplist);
        	stdSetController.setSelected(oplist);
        	openorderController ext = new openorderController(stdSetController);
        	ext.saveTwo(); 
        test.stopTest(); 
    }
}