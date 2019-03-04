
@isTest
private class Test_AttachLineItem {
    
    private static testMethod void test_AttachLineItem() {
        
        //Create area
        Area__c oArea = new Area__c();
        oArea.Name = 'Test Green';
        insert oArea;
        
        //Create Test ContentVersion
        ContentVersion oContentVersion = new ContentVersion();
        oContentVersion.Title = 'TestTitle';
        oContentVersion.PathOnClient = 'TestTitle.png';
        oContentVersion.VersionData = Blob.valueOf('Test Content');
        insert oContentVersion;
        
        //Get the contentDocId, just in case
        ContentVersion queryContentVersion = [Select Id, ContentDocumentId FROM ContentVersion Where Id =: oContentVersion.Id];
        
        Test.startTest();
        
        Test.setCurrentPage(Page.Attach_LineItem);
        Apexpages.currentPage().getParameters().put('id', oArea.Id);
        
        AttachPDFQuoteLineItem oController = new AttachPDFQuoteLineItem();
        oController.savePDF_File();
        
        Test.stopTest();
        
    }

}