@istest
private class Test_lineItemController {
    static testMethod void Test_lineItemController(){
        PageReference pref = Page.lineItem;         
        Test.setCurrentPage(pref);
        //account
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;
        //contact
        contact person = new contact(lastname = 'test', AccountId = cust.Id);
        insert person; 
        //date and pricebook don't know if you need it just incase 
        Date myDate = Date.newInstance(2040, 1, 4);
        Date startdate = Date.newInstance(2040, 1, 3);
        Id pricebookId = Test.getStandardPricebookId();
        //opportunity
        opportunity opp = new opportunity(name = 'test name', accountID= cust.id, pricebook2id = pricebookId,Target_Start_Date__c = startdate,
                                         Contact__c = person.id, stagename='Estimate(10%)', job_type__c = 'Construction', closedate = mydate);
	
        insert opp;
        //insert products 
        product2 p = new product2(Name='some', ProductCode =  'jdt-23');
        product2 pr = new product2(Name='thing', ProductCode =  'xyz');
        insert p;
        insert pr; 
        
        quote tq =  new quote(name='test', OpportunityId=opp.id, pricebook2id = pricebookId);
         insert tq;       
        
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=p.id,
                                                 unitprice=4, IsActive = True, UseStandardPrice=False);
        PricebookEntry pb = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id=pr.id,
                                                 unitprice=1, IsActive = True, UseStandardPrice=False);
        insert pbe;
        insert pb; 
      
        quotelineitem ql = new quotelineitem(QuoteId = tq.id, Product2Id=p.id, pricebookentryid = pbe.id, UnitPrice=4, Quantity=1);
        quotelineitem qli = new quotelineitem(QuoteId = tq.id, Product2Id=pr.id,  pricebookentryid = pb.id, UnitPrice=1, Quantity=1);


       
        
         Test.startTest();
        insert ql;
        insert qli;
         ApexPages.StandardController sc = new ApexPages.StandardController(opp);

        // create the controller
        lineItemController ext = new lineItemController(sc);

        list<quotelineitem> product = ext.getproduct();   
        system.debug('test quote-> ' +tq);
        system.debug('quotelineID ** '+ ql.quoteid);
        system.assertNotEquals(product, null);
       		list<quote> c =  ext.getx();
        system.debug('here is con.getx  '+ c );
        system.assertNotEquals(c, null);
        
        
        for(quotelineitem x : product){
        system.assertEquals(x.quantity,0);
            if(x.Product_Code__c.startsWith('JDT')){
            system.assertEquals(x.unitprice, x.TotalPrice);
            }}   Test.stopTest();     
    }

}