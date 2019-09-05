@isTest
private class test_ContentDocumentLinkTrigger {
    @isTest
    static void testInsert(){
       // setup a new account
		Account cust = new Account(name='Test123456', type= 'Customer', Customer_Name__c = 'Test Customer 123456');
         insert cust; 
        
        //needed for work order to be inserted  
        Id pricebookId = Test.getStandardPricebookId();
        Contact c = new Contact(lastname= 'something', AccountId = cust.id );
        insert c;
        //this is needed to get a test user 
 		User u1 = [SELECT Id FROM User WHERE Lastname like 'Test%'];
        datetime SD = datetime.newInstance(2019, 1, 15, 12, 30, 0);
        datetime ED = datetime.newInstance(2019, 1, 16, 12, 30, 0);
        //date for opportunity
        Date oppDate = Date.newInstance(2040, 1, 4);
        
  
        
        //setup opp with no workorder id 
        opportunity opp = new opportunity(name = 'test name', accountID= cust.id, pricebook2id = pricebookId, contact__c = c.id, 
                                         stagename='Estimate(10%)', job_type__c = 'Construction', closedate = oppDate); 
        
        opportunity opp2 = new opportunity(name = 'workorder', accountID= cust.id, pricebook2id = pricebookId, contact__c = c.id, 
                                         stagename='Estimate(10%)', job_type__c = 'Construction', closedate = oppDate);
         insert opp;
         insert opp2; 
        //setup workorder
        WorkOrder wo = new WorkOrder(ContactId = c.id, Area_Manager__c = u1.id, Pricebook2Id = pricebookID, StartDate = Sd, EndDate = ED, opportunity__c = opp2.Id); 
        insert wo; 
        
    //setup document link. Setting it up this way then querying it and adding it to the link below was how it was recommended to be done on the stackoverflow for Apex
   		ContentVersion file = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'Test.jpg',
            VersionData = Blob.valueOf('Test Content Data'),
            IsMajorVersion = true
        );
        insert file;
        List<ContentDocument> documents = [Select Id, title, LatestPublishedVersionID from ContentDocument];
        
        ContentDocumentLink link = new ContentDocumentLink(ContentDocumentId = documents[0].id, LinkedEntityId = opp2.Id, ShareType = 'V', Visibility = 'InternalUsers');
    //Now testing
        Test.startTest();
        	insert link; 
        Test.stopTest();
        ContentDocumentLink opportunity = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: opp2.id ];
        ContentDocumentLink workorder = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: wo.id ];
        system.assertEquals(opportunity.ContentDocumentId, workorder.ContentDocumentId);
        //system.debug('opp '+ opportunity.ContentDocumentId + ' work ' + workorder.ContentDocumentId); 
    }
}