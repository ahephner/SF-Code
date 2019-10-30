@isTest
public class testExpenseToAsset {
	@isTest
    Static void testTrigger(){
        ATS_Asset__c ta = new ATS_Asset__c(name = 'test', tires__c = 0,P_M__c=0,Repair__c=0);
         insert ta; 
         
        Expense__c tire= new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'Tires', Amount__c=1,Expense_Date__c = date.newInstance(2019, 10, 30) );
        Expense__c pm= new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'PM', Amount__c=2,Expense_Date__c = date.newInstance(2019, 10, 30) );
        Expense__c repair= new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'Repair', Amount__c=3,Expense_Date__c = date.newInstance(2019, 10, 30) );
        
        Test.startTest();
        	insert tire; 
        	insert pm; 
        	insert repair;
        Test.stopTest();

        
    }
}