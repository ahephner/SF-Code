@isTest
public class LeadProcessorTest {
	@testSetup
    static void setUp(){
        List<Lead> leads = new List<Lead>();
        
        for(Integer i=0; i<200; i++){
            leads.add(new lead(lastname='person '+i, company='company '+i, Status = 'Open - Not Contacted')); 
        }
        insert leads; 
    }
    
    static testMethod void test(){
        Test.startTest();
        	LeadProcessor lp = new LeadProcessor(); 
        	Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        
        System.assertEquals(200, [select count() from lead where leadsource = 'Dreamforce']); 
    }
}