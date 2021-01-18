@isTest
private class Test_OpportunityClone {
    @isTest
    static void Test_OpportunityClone(){
         PageReference pref = Page.oppCloneWithProducts;
        Test.setCurrentPage(pref);
        //date for opp
        Date myDate = Date.newInstance(2040, 1, 4);
        //create test customer
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;
        //product creation
        Id pricebookId = Test.getStandardPricebookId();
        
        //create product2 that is active
        product2 prod = new product2(name ='product', IsActive= True); 
        insert prod; 
        
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=prod.id,
                                                 unitprice=4, IsActive = True, UseStandardPrice=False);
        insert pbe; 
        
        //create product2 that will be deactivated
        product2 widget = new product2(name ='widget', IsActive= True); 
        insert widget; 
        
        PricebookEntry widgetpbe = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=widget.id,
                                                 unitprice=4, IsActive = True, UseStandardPrice=False);
        insert widgetpbe; 
        //create test opportunity
        opportunity opp = new opportunity(name = 'test name', accountID= cust.id, pricebook2id = pricebookId,
                                         stagename='Estimate(10%)', job_type__c = 'Construction', closedate = myDate);
       
        //insert w/o synced quote
        insert opp; 
       
//opportunitylineitem
        opportunitylineitem li = new opportunitylineitem(opportunityid = opp.id, product2id = prod.Id, PricebookEntryId=pbe.id,
                                                         unitprice= 4, quantity= 3); 
        insert li; 
        opportunitylineitem widgetli = new opportunitylineitem(opportunityid = opp.id, product2id = widget.Id, PricebookEntryId=widgetpbe.id,
                                                         unitprice= 4, quantity= 3); 
        insert widgetli;
        

        //construct standard controller
        ApexPages.StandardController con = new ApexPages.StandardController(opp);
        
        //create the controller
        oppCloneWithProducts clone = new oppCloneWithProducts(con);
        system.debug('clone '+clone);
        Test.startTest();
            //call the clonemethod
            PageReference method = clone.cloneOpp();
            widget.IsActive = false; 
            update widget; 
            //create matching page referenc
            //PageReference redir = new PageReference('/lightning/r/Opportunity/'+method.Id+'/view'); 
            opportunity clonedOp = [select id from opportunity where id = :clone.newOppID];
        system.debug('cloned opp -> '+clonedOp);
            system.assertNotEquals(clonedOp, null); 
            list<opportunitylineitem> cli = [select opportunityid from opportunitylineitem where opportunityid = :clonedOp.Id];
            list<opportunitylineitem> nonactive = [select opportunityid from opportunitylineitem where opportunityid = :clonedOp.Id and PriceBookEntry.IsActive = false];
            system.debug('CLI '+ cli);
            system.debug('nonactive '+ nonactive);
            system.assertEquals(cli.size(), 2); 
            system.assertEquals(nonactive.size(), 1); 
         test.stopTest();
        
    }

}
