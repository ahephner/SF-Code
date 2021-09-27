@isTest
public class test_itemTransferController {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    @isTest
    static void testScheduledJob(){
        Test.startTest();
        string jobId = System.schedule('ScheduledApexTest', CRON_EXP, new itemTransferSchedule());
        Test.stopTest();
    }
    
    @isTest
    static void testItemTransfer(){
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.RecordTypeId = '01241000001Dy64AAC';
        cust.Customer_Name__c = 'Test Customer 123456';
        	insert cust;
    	//Sales Rep
    	Sales_Rep__c sr = new Sales_Rep__c(Name='Rep', Sales_Rep_Num__c='12');
    	insert sr; 

        //date and pricebook don't know if you need it just incase 
        Date myDate = Date.newInstance(2040, 1, 4);

        //sales doc
        Sales_Document__c head = new Sales_Document__c(name = 'SO123', customer__c = cust.id, Doc_Type__c = 'Invoice', 
                                                       Sales_Doc_Num__c = '12345',Sales_Rep__c= sr.Id,
                                                       Doc_Date__c = myDate, Doc_Amount__c=1.00,Payment_Terms__c = 'SEE SPLIT TERMS' );
        insert head; 
        Sales_Document__c head2 = new Sales_Document__c(name = 'SO124', customer__c = cust.id, Doc_Type__c = 'Invoice', 
                                                       Sales_Doc_Num__c = '123456',Sales_Rep__c= sr.Id,
                                                       Doc_Date__c = myDate, Doc_Amount__c=1.00,Payment_Terms__c = 'SEE SPLIT TERMS' );
        insert head2; 
        //line item
        Item_Transfer__c lit = new Item_Transfer__c(name = 'ITM123', Open_Order_Number__c = 'SO123', Invoiced__c = true, batch__c = 'true');
        insert lit;
        Item_Transfer__c lit2 = new Item_Transfer__c(name = 'ITM1234', Open_Order_Number__c = 'SO124', Invoiced__c = true, batch__c = 'true');
        //test
        test.startTest();
			itemTransferController.updateTransfers();
        	list<Item_Transfer__c> itemList = [select id from item_transfer__c where Sales_Document__c != null];
        test.stopTest();
        
        system.assertEquals(itemList.size(), 2); 
    }
}