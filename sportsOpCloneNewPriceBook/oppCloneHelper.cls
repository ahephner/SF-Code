//code I used for most of this https://developer.salesforce.com/forums/?id=906F00000008zJLIAY
//used a map instead on the insert otherwise it clones but the products are different than qty etc. 
public class oppCloneHelper {
    public static void pbeEntries(id OppId, id newOpId){
        string newPriceBookId = '01s17000003ccClAAI';
        List<OpportunityLineItem> lineItems = [SELECT opportunityid, product2id, unitprice, quantity, 
                                                   rate__c, listprice, Description, Per_1_000__c, Per_Acre__c
                                                   from opportunitylineitem where opportunityid = :oppId and PriceBookEntry.IsActive = true];
       Map<Id, OpportunityLineItem> prodMap = new Map<Id, OpportunityLineItem>();
        
        for(OpportunityLineItem x:lineItems){
            prodMap.put(x.product2Id, x);
        }
      // system.debug('map  '+prodMap.keySet());
       List<PricebookEntry> pbe = [Select id, product2Id from pricebookentry where pricebook2id =: newPriceBookId and product2Id in: prodMap.keySet()];
      	 Map<Id, pricebookentry> pbeMap = new Map<Id, pricebookentry>();
        
        for(pricebookentry x:pbe){
            pbeMap.put(x.product2Id, x);
        }
      //  system.debug('pbe Map '+pbeMap);
       List<opportunitylineitem> newLines = new List<opportunitylineitem>();
        
        //Integer count = 0; 
        for(opportunitylineitem ol: lineItems){
            
            system.debug('loop '+ ol.Product2Id + ' qty '+ol.Quantity);	
            newLines.add(new OpportunityLineItem(					
                PricebookEntryId = pbeMap.get(ol.Product2Id).id,
                product2id = ol.product2id,
                quantity = ol.quantity,
                unitprice = ol.unitprice,
                rate__c = ol.rate__c,
                //listprice = ol.listprice,
                description = ol.description,
                Per_1_000__c = ol.Per_1_000__c,
                Per_Acre__c = ol.Per_Acre__c,
                OpportunityId  = newOpId
                					
            ));
            //count ++; 
        }
        if(newLines.size()>0){
            system.debug('size of new '+newLines.size()); 
            insert newLines; 
        }        
    }
}