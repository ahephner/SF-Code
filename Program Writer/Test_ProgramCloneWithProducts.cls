//91% on 12/11/19

@isTest
private class Test_ProgramCloneWithProducts {
@isTest
    static void Test_ProgramCloneWithProducts(){
        
        //set up a reference to the page the controller is expecting with parameters
        PageReference PR = Page.ProgramCloneWithProducts; 
        Test.setCurrentPage(PR); 
        
        //setuup a new account 
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;
        //setup a new program
        Program__c pro = new Program__c(); 
        pro.Name = 'Test Class';
        pro.Account__c = cust.id;
        insert pro; 
        
        //create area
        Area__c area = new Area__c(); 
        area.Name = 'Yard';
        area.Program__c = pro.id;
        area.Area_Acres__c = 10;
        insert area;
        
        //new application note no products that is handled on the trigger
        Application__c app = new Application__c();
        app.Area__c = area.id;
        app.Date__c = Date.newInstance(2020, 07, 04);
        app.Name = 'Summer Test';
        insert app; 
        
        //construct the standard controller
        ApexPages.StandardController con = new ApexPages.StandardController(pro);
        
        //Create controller
        ProgramCloneWithApps_Controller cl = new ProgramCloneWithApps_Controller(con);
        
        Test.startTest();
        
        PageReference ref = cl.cloneProgram();
        
        PageReference redir = new PageReference('/lightning/r/Program__c/'+cl.newProgramID +'/view');
        
        Program__c newPro = [select id from program__c where id = :cl.newProgramId];
        System.assertNotEquals(newPro, null); 
        
        Area__c newArea = [select id from area__c where program__c = :newPro.Id];
        system.assertNotEquals(newArea, null);
        
        List<Application__c> newApp = [select id from application__c where area__c = :newArea.id];
        system.assertEquals(newApp.size(), 1); 
        
        Test.stopTest(); 
        
    }
}