@isTest()
public class test_rewardsListView {
    private static testmethod void rewardsListViewTest(){
                //account
       
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
        Sales_Document__c head = new Sales_Document__c(name = 'test name', customer__c = cust.id, Doc_Type__c = 'Invoice', 
                                                       Sales_Doc_Num__c = '12345',Sales_Rep__c= sr.Id,
                                                       Doc_Date__c = myDate, Doc_Amount__c=1.00,Payment_Terms__c = 'SEE SPLIT TERMS' );
        
        list<sales_document__c> selected = new list<sales_document__c>();
        selected.add(head);
        
        //the actual visualforce page
        PageReference pageRef = Page.salesDocRewardsListView;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(selected);
        rewardsListView l = new rewardsListView(sc); 
    }
}