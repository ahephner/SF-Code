trigger QuoteTrigger on Quote ( after insert) {
    if(Trigger.isInsert){
        	map<id, id> quoteMap = new map<id, id>(); 
        for(Quote currentQuote: Trigger.New){
            quoteMap.put(currentQuote.Id, currentQuote.OpportunityId);
        }
            
        quoteController.syncQuote(quoteMap);
    }
}