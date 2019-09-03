trigger ContentDocumentLinkTrigger on ContentDocumentLink ( after insert ) {

    ContentDocumentLinkTriggerHandler handler = new ContentDocumentLinkTriggerHandler();

   		for(ContentDocumentLink cdl : trigger.new) {
       
        handler.handleAfterInsert( cdl );
    }

}