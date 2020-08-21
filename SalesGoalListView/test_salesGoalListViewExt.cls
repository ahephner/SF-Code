@isTest //85%
public class test_salesGoalListViewExt {
    static testMethod void validateExt(){
        date day = date.newInstance(2040, 1, 4);
     //list is needed for the setcontroller
     list<sales_goal__c> sgList = new list<sales_goal__c>(); 
	//Sales Rep
    	Sales_Rep__c sr = new Sales_Rep__c(Name='Rep', Sales_Rep_Num__c='12');
    	insert sr;
     //product
     product__c p = new product__c(Name='xyz', Product_Name__c = 'product', Active__c=True);
     insert p; 
     //sales goal
     sales_goal__c sg = new sales_goal__c(name='name', product__c = p.Id, 
                                          sales_rep__c = sr.id,
                                          budget_type__c = 'Total Sales', 
                                          Date__c = day);
        insert sg;
        sgList.add(sg); 
     
        ApexPages.StandardSetController con = new ApexPages.StandardSetController(sgList); 
        salesGoalListViewExt ext =  new salesGoalListViewExt(con);
     
    }
}

