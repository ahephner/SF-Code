public with sharing class quoteController {
	@future
    public static void syncQuote(map<Id, Id> quoteMap){
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
        
        for(id x:quoteMap.keyset()){
            Opportunity opp = new Opportunity();
            opp.Id = quoteMap.get(x);
            opp.SyncedQuoteId = x; 
            oppMap.put(opp.Id, opp);
        }
        update oppMap.values(); 
        
    }
}