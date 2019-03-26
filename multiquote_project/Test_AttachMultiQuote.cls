@isTest
private class Test_AttachMultiQuote {
    static testMethod void Test_AttachMultiQuote(){
        //Create area
       PageReference pref = Page.multiQuotepdf;         
        Test.setCurrentPage(pref);
        //account
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;
        //date and pricebook don't know if you need it just incase 
        Date myDate = Date.newInstance(2040, 1, 4);
        Id pricebookId = Test.getStandardPricebookId();
        
        //contact needed for the process builder auto sync quote to opportunity to pass
        Contact a = new contact(lastname = 'Wick', accountid = cust.Id);
        insert a; 
        
        
        
        //opportunity
        opportunity opp = new opportunity(name = 'test name', accountID= cust.id, pricebook2id = pricebookId, contact__c = a.id, 
                                         stagename='Estimate(10%)', job_type__c = 'Construction', closedate = mydate);
	
        insert opp;
        //insert products 
        product2 p = new product2(Name='some', ProductCode =  'jdt-23');
        product2 pr = new product2(Name='thing', ProductCode =  'xyz');
        
        
        quote tq =  new quote(name='test', OpportunityId=opp.id, pricebook2id = pricebookId);
         insert tq;       
        
       

        Area__c oArea = new Area__c();
        oArea.Name = 'Test Green';
        insert oArea;
        
        //Create Test ContentVersion
        ContentVersion oContentVersion = new ContentVersion();
        oContentVersion.Title = 'TestTitle';
        oContentVersion.PathOnClient = 'TestTitle.pdf';
        oContentVersion.VersionData = Blob.valueOf('Test Content');
        insert oContentVersion;
        
        //Get the contentDocId, just in case
        ContentVersion queryContentVersion = [Select Id, ContentDocumentId FROM ContentVersion Where Id =: oContentVersion.Id];
        
        Test.startTest();
        Test.setCurrentPage(Page.multiQuote);
        Apexpages.currentPage().getparameters().put('id', tq.Id); 
        ApexPages.StandardController con = new ApexPages.StandardController(tq);
        multiquoteController ext = new multiquoteController(con); 
        insert p;
        insert pr;  
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=p.id,
                                                 unitprice=4, IsActive = True, UseStandardPrice=False);
        PricebookEntry pb = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=pr.id,
                                                 unitprice=1, IsActive = True, UseStandardPrice=False);
        insert pbe;
        insert pb; 
      
        quotelineitem ql = new quotelineitem(QuoteId = tq.id, Product2Id=p.id, pricebookentryid = pbe.id, UnitPrice=4, Quantity=1);
        quotelineitem qli = new quotelineitem(QuoteId = tq.id, Product2Id=pr.id,  pricebookentryid = pb.id, UnitPrice=1, Quantity=1);
        ext.savePDF_File(); 

        Test.stopTest();
    }
    

}