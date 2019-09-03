public with sharing class ContentDocumentLinkTriggerHandler {

    public void handleAfterInsert( contentdocumentlink cdl) {
			//system.debug('here linked '+cdl.LinkedEntityId);
        string id = cdl.LinkedEntityId;
        	WorkOrder wo = [select id from workorder where opportunity__c =: id];
        
        if(wo == null){
            system.debug('Nothing to see');
        }else{
            contentdocumentlink newLink = new contentdocumentlink();
            newLink.LinkedEntityId = wo.id;
            newLink.ContentDocumentId = cdl.ContentDocumentId;
            newLink.ShareType = cdl.ShareType;
            newLink.Visibility = cdl.Visibility;
            system.debug(newLink);
        }
        
    }
}