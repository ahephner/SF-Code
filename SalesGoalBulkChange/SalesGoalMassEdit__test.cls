@isTest
private class massSalesGoalEdit_test {
    @testSetup
    static void setUp(){
        Sales_rep__c Rep = new Sales_Rep__c(name='Another rep',
                                            Sales_Rep_Num__c = '999',
                                            Fiscal_Year__c = 'Sales'
        									);
        insert Rep; 
        
        date today = system.today();
        list<Sales_Goal__c> goals = new list<Sales_Goal__c>(); 
        
        for(Integer i=0; i<15; i++){
            goals.add(new sales_goal__c(
            			  Budget_Type__c = 'Monthly Sales',
                          Date__c = today,
            			  Name = 'goal '+i,
            			  Sales_Rep__c = Rep.id,
            			  Total_Budget_Amount__c = i));
        }
        insert goals; 
           }
    
     @isTest
        static void testMeth(){
            string params = 'inactive__c = false';
            test.startTest();
            MassSalesGoalEdit mg = new MassSalesGoalEdit(params); 
            Database.executeBatch(mg);
            test.stopTest(); 
            
            list<sales_goal__c> finished = [select id, inactive__c from sales_goal__c];
            system.assertEquals(finished[0].inactive__c, true);
            
        }

    
}