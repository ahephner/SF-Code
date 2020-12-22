@isTest
public class test_salesGoalListViewExt {
    @testSetup
    static void setUp(){
        date day = date.newInstance(2040, 1, 4);
     
      
	//Sales Rep
    	Sales_Rep__c sr = new Sales_Rep__c(Name='Rep', Sales_Rep_Num__c='12');
    	insert sr;
     //products for product goals
     product__c p1 = new product__c(Name='xyz', Product_Name__c = 'product', Active__c=True);
     insert p1; 
     product__c p2 = new product__c(Name='stuff', Product_Name__c = 'things', Active__c=True);
     insert p2; 
     //accounts for account goal
     string rid = [select id from recordtype where description like 'Customer Account'].id;
        Account cust1 = new Account(name='Abc', RecordTypeID= rid, Customer_Name__c = '1 - Abc');
		Account cust2 = new Account(name='Bcd', RecordTypeID= rid, Customer_Name__c = '2 - Bcd');
       insert cust1;
       insert cust2; 
        
     //sales goal - product
     sales_goal__c prod1 = new sales_goal__c(name='name', product__c = p1.Id,sales_rep__c = sr.id,
                                             budget_type__c = 'Total Sales',Prev_Qty__c = 1,Date__c = day);
        insert prod1;
     sales_goal__c prod2 = new sales_goal__c(name='go pro', product__c = p2.Id,sales_rep__c = sr.id,
                                            Prev_Qty__c = 2,budget_type__c = 'Total Sales',Date__c = day);
        insert prod2;
     //sales goal - customer
     sales_goal__c c1 = new sales_goal__c(name='first customer', customer__c = cust1.id ,sales_rep__c = sr.id,
                                          budget_type__c = 'Monthly Sales',Date__c = day);
     sales_goal__c c2 = new sales_goal__c(name='second customer', customer__c = cust2.id ,sales_rep__c = sr.id,
                                          budget_type__c = 'Monthly Sales',Date__c = day);
        insert c1;
        insert c2; 
    }
    @isTest
     static void validateAccountGoal(){
         string searchTerm = 'Monthly Sales';
         list<sales_goal__c> selectList = [select id, customer__r.id, customer_name__c, Prev_Month_Rep_Forecast__c,
                 Current_Month_Prev_Year__c, Forecast_Amount__c,Updates__c, Product_Name__c,
                 Product__r.ID, Actual_Amount__c, Prev_Qty__c,Qty_Forecast__c from
                 sales_goal__c where budget_type__c =: searchTerm];
         
        ApexPages.StandardSetController con = new ApexPages.StandardSetController(selectList); 
        salesGoalListViewExt ext =  new salesGoalListViewExt(con);
        test.startTest();
         ext.lvn = '00B2h000000zIC1EAM'; 
         ext.orderByCustomerName();
         ext.sgList = selectList; 
         ext.sgList[0].Forecast_Amount__c = 100; 
         ext.updateRecord(); 
        test.stopTest(); 
        //system.debug('account '+ ext.sgList[0].Customer_Name__c);
        system.assertEquals('1 - Abc', ext.sgList[0].Customer_Name__c);
        system.assertEquals(100.00, ext.sgList[0].Forecast_Amount__c); 
    }
    
    @isTest 
    static void validateProdGoal(){
        string w = 'Total Sales';
        list<sales_goal__c> l = [select id, customer__r.id, customer_name__c, Prev_Month_Rep_Forecast__c,
                 Current_Month_Prev_Year__c, Forecast_Amount__c,Updates__c, Product_Name__c,
                 Product__r.ID, Actual_Amount__c, Prev_Qty__c,Qty_Forecast__c from
                 sales_goal__c where budget_type__c =: w];
        ApexPages.StandardSetController con = new ApexPages.StandardSetController(l); 
        salesGoalListViewExt ext =  new salesGoalListViewExt(con);
        test.startTest();
        	ext.lvn = '00B2h000000zq1dEAA'; 
        	ext.orderByProduct();	
        	ext.sgList = l;
        	ext.sgList[0].Qty_Forecast__c = 2; 
        	ext.updateRecord(); 
        test.stopTest(); 
        decimal updatedAmount = [select id, Qty_Forecast__c from Sales_Goal__c where name = 'name' ].Qty_Forecast__c; 
        system.assertEquals(2.00, updatedAmount); 
    }
}