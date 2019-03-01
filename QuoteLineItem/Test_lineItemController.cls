@istest
private class Test_lineItemController {
    static testMethod void Test_lineItemController(){
        //account
        Account cust = new Account();
        cust.Name = 'Test123456';
        cust.Type = 'Customer';
        cust.Customer_Name__c = 'Test Customer 123456';
        insert cust;
        //date and pricebook don't know if you need it just incase 
        Date myDate = Date.newInstance(2040, 1, 4);
        Id pricebookId = Test.getStandardPricebookId();
        //opportunity
        opportunity opp = new opportunity(name = 'test name', accountID= cust.id, pricebook2id = pricebookId,
                                         stagename='Estimate(10%)', job_type__c = 'Construction', closedate = mydate);
		insert opp;
        
        //insert products 
        product2 p = new product2(Name='some', ProductCode =  'jdt');
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
        quotelineitem qli = new quotelineitem(QuoteId = tq.id, Product2Id=pr.id, pricebookentryid = pb.id, UnitPrice=1, Quantity=1);
        insert ql;
        insert qli; 
        Test.startTest();

        Test.setCurrentPage(Page.LineItem);
        system.debug('quoteline item -> ' + ql);
        lineItemController con = new lineItemController();
        list<quotelineitem> product = con.getproduct(); 
        system.debug('product list-> ' +product);
        system.assertNotEquals(product, null);

        //error here saying no rows to assign a list ??/
       // quote x =  con.getx();
        //system.assertNotEquals(x, null);
        Test.stopTest();
        
        
    }

}