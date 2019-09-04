public with sharing class ContentDocumentLinkTriggerHandler {

    public void handleAfterInsert( contentdocumentlink cdl) {
			//system.debug('here linked '+cdl.LinkedEntityId);
        	string id = cdl.LinkedEntityId;
        	WorkOrder wo; 
        try{
        	 wo = [select id from workorder where opportunity__c =: id];
        }catch(Exception ex){
            wo = null; 
        }
        if(wo == null){
            system.debug('Nothing to see');
        }else{
            contentdocumentlink newLink = new contentdocumentlink();
            newLink.LinkedEntityId = wo.id;
            newLink.ContentDocumentId = cdl.ContentDocumentId;
            newLink.ShareType = cdl.ShareType;
            newLink.Visibility = cdl.Visibility;
            insert newLink;
        }
        
    }
}