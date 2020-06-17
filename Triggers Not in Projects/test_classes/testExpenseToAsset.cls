@isTest
public class testExpenseToAsset {
  @isTest
    Static void testTrigger(){
        Account cust = new Account(Name = 'Test123456',RecordTypeId = '01241000001Dy5zAAC',Customer_Name__c = 'Test Customer 123456');
        insert cust;
        
        Location__c location = new Location__c(Name = 'Test', Account__c=cust.id); 
        insert location; 
        
        ATS_Asset__c ta = new ATS_Asset__c(name = 'test', ATS_Location__c= location.id, 
                                           tires__c = 0,P_M__c=0,Repair__c=0,Tolls__c = 0,
                                           Miscellaneous__c= 0, Asset_Type__c='Dump Truck (DT)');
         insert ta; 
         
        Expense__c tire= new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'Tires', Amount__c=1,Expense_Date__c = date.newInstance(2019, 10, 30) );
        Expense__c pm= new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'PM', Amount__c=2,Expense_Date__c = date.newInstance(2019, 10, 30) );
        Expense__c repair= new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'Repair', Amount__c=3,Expense_Date__c = date.newInstance(2019, 10, 30) );
        Expense__c misc = new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'Miscellaneous', Amount__c=3,Expense_Date__c = date.newInstance(2019, 10, 30) );
        Expense__c tolls = new Expense__c(ATS_Asset__c=ta.Id,Expense_Type__c = 'Tolls', Amount__c=3,Expense_Date__c = date.newInstance(2019, 10, 30) );
        Test.startTest();
          insert tire; 
          insert pm; 
          insert repair;
            insert misc;
          insert tolls;
        //updates
        tire.Amount__c = 15; 
        pm.Amount__c = 100;
        repair.Amount__c = 100;
        misc.Amount__c = 6;
        tolls.Amount__c = 3; 
        update tire;
        update pm;
        update repair;
        update misc; 
        update tolls;
        
        tire.Amount__c = 3; 
        pm.Amount__c = 1;
        repair.Amount__c = 1;
        misc.Amount__c = 2;
        tolls.Amount__c =5; 
        update tire;
        update pm;
        update repair;
        update misc;
        update tolls;
        //now test delete
          delete tire;
          delete pm; 
          delete repair; 
            delete misc; 
          delete tolls;
        Test.stopTest();

        
    }
}