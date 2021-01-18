public class oppCloneWithProducts {
    
    private ApexPages.StandardController controller {get; set;}
    
    private Opportunity opp {get; set;}
    //private Product2 prods {get; set;}
    //set the id of the record that is created --Only used by Test Class
    public ID newOppID {get; set;}
    private string nonActiveItem = ''; 
    //start the controller
    public oppCloneWithProducts(ApexPages.StandardController controller){
        
        this.controller = controller;
        //grab this record
        opp = (Opportunity)controller.getRecord();
    }
    //action
    public PageReference cloneOpp(){
       
        //Rollback point
        Savepoint sp = Database.setSavepoint();
        //new Opportunity Var
        Opportunity newOp;
        List<OpportunityLineItem> opli = new List<OpportunityLineItem>(); 
       // Date cd = System.today() + 30; 
         
        try{
         opp = [SELECT Id, Name, AccountId, CloseDate, Job_Type__c, StageName,  Sales_Rep__r.OwnerId, 
                RecordType.Id, Contact__c, pricebook2.id,Type, Target_Area__c,
                Target_Start_Date__c, description FROM Opportunity where id = :opp.Id]; 
  
            newOp = opp.clone(false);
            
            newOp.Name += ' Cloned';
            newOp.StageName = 'Estimate(10%)';
         //   newOp.CloseDate = cd;  
            insert newOp; 
            system.debug('here new opp -> ' +newOp);
           //test
            newOppID = newOp.Id;
 //get opportunity line items that are still have active pricebook entries
            List<OpportunityLineItem> lineItems = [SELECT opportunityid, product2id, unitprice, quantity, 
                                                   rate__c, listprice, Description, Per_1_000__c, Per_Acre__c
                                                   from opportunitylineitem where opportunityid = :opp.Id and PriceBookEntry.IsActive = true];
            
  //loop over and clone valid entries then insert them into the system
            for(OpportunityLineItem x : lineItems){
                opportunitylineitem oppLine = x.clone(false);
                oppLine.OpportunityId = newOp.Id;
                opli.add(oppLine);
            }
            //system.debug(opli);
            if(!opli.isempty()){
                insert opli; 
            }
//Look and see if there are any non active items from the old quote            
            List<Opportunitylineitem> nonActiveItems = [SELECT product2.name, unitprice, quantity, 
                                                   		rate__c, listprice, Description, Per_1_000__c, Per_Acre__c
                                                   		from opportunitylineitem where opportunityid = :opp.Id and PriceBookEntry.IsActive = false]; 
//Turned the @mention to just show Sean due to his request. To turn to a rep see --> {'+opp.Sales_Rep__r.OwnerId+'}             
            if(nonactiveItems.size()>0){
                for(Opportunitylineitem i: nonActiveItems){
                   // system.debug(nonActiveItem);
                    nonActiveItem +='* '+ i.product2.name + '  UNIT PRICE:  $'+ i.UnitPrice +'  QTY: '+ i.Quantity + '\n' +'\n'; 
                }
                ConnectApiHelper.postFeedItemWithMentions(Network.getNetworkId(), newOp.id, '{00541000007ALGeAAO} these products are no longer active and were on the old quote '+'\n'+nonActiveItem );
            }
            
        }catch(exception i){
            Database.rollback(sp);
            ApexPages.addMessages(i); 
            return null; 
        }
        return new PageReference('/lightning/r/Opportunity/'+newOp.id+'/view'); 
    }
}
//****Previous Version Before Quip USES Quotes */

// public class oppCloneWithProducts {
    
//     private ApexPages.StandardController controller {get; set;}
    
//     private Opportunity opp {get; set;}
//     //private Product2 prods {get; set;}
//     //set the id of the record that is created --Only used by Test Class
//     public ID newOppID {get; set;}
    
//     //start the controller
//     public oppCloneWithProducts(ApexPages.StandardController controller){
        
//         this.controller = controller;
//         //grab this record
//         opp = (Opportunity)controller.getRecord();
//     }
//     //action
//     public PageReference cloneOpp(){
       
//         //Rollback point
//         Savepoint sp = Database.setSavepoint();
//         //new Opportunity Var
//         Opportunity newOp;
//         List<OpportunityLineItem> opli = new List<OpportunityLineItem>(); 
//        // Date cd = System.today() + 30; 
//         quote quote; 
//         try{
//          opp = [SELECT Id, Name, AccountId, CloseDate, Job_Type__c, StageName,
//                 RecordType.Id, Contact__c, pricebook2.id,Type, Target_Area__c,
//                 Target_Start_Date__c, description,Work_Type__c  FROM Opportunity where id = :opp.Id]; 
          
//             quote = [select BillingCity, BillingCountry, BillingName, BillingState, 
//                    BillingStreet, BillingPostalCode, ContactId, Description, Email, ExpirationDate, 
//                    Phone, QuoteToCity, QuoteToCountry, QuoteToName, QuoteToState, QuoteToStreet,
//                    QuoteToPostalCode, ShippingCity, ShippingCountry, ShippingName, ShippingState, 
//                    ShippingStreet, ShippingPostalCode, Start_Date__c  from quote where opportunityid = :opp.ID and IsSyncing = true];  
//             newOp = opp.clone(false);
            
//             newOp.Name += ' Cloned';
//             newOp.StageName = 'Estimate(10%)';
//          //   newOp.CloseDate = cd;  
//             insert newOp; 
//             system.debug('here new opp -> ' +newOp);
//             system.debug('here is that quote ' +quote.BillingName);
//             Quote q = new Quote(); 
            
//             q.name = newOp.Name;
//             q.OpportunityId = newOp.Id; 
//             insert q; 
//             newOp.SyncedQuoteId = q.Id; 
//             update newOp; 
			
//             q.BillingName = quote.BillingName;
//             q.BillingCity = quote.BillingCity;
//             q.billingstate = quote.BillingState;
//             q.billingstreet = quote.BillingStreet; 
//             q.BillingPostalCode = quote.BillingPostalCode;
//             q.Description= quote.Description;
//             q.ContactId = quote.ContactId; 
//             q.email = quote.email;
//             q.ExpirationDate = quote.ExpirationDate;
//             q.Phone = quote.phone;
//             q.QuoteToCity = quote.QuoteToCity;
//             q.QuoteToCountry = q.QuoteToCountry;
//             q.quotetoname = quote.quotetoname;
//            // q.QuoteToState = quote.QuoteToState;
//             //q.QuoteToStreet= quote.QuoteToStreet;
//             //q.QuoteToPostalCode = quote.QuoteToPostalCode;
//             //q.ShippingStreet = quote.ShippingStreet; 
//             //q.ShippingState = quote.Shippingstate; 
//             //q.ShippingCity = quote.ShippingCity;
//             //q.ShippingName = quote.ShippingName;
//             q.Start_Date__c = quote.Start_Date__c;
//             update q; 
       
            
       
//             List<OpportunityLineItem> lineItems = [SELECT opportunityid, product2id, unitprice, quantity,
//                                                    rate__c, listprice, Description, Per_1_000__c, Per_Acre__c
//                                                    from opportunitylineitem where opportunityid = :opp.Id];
//             for(OpportunityLineItem x : lineItems){
//                 opportunitylineitem oppLine = x.clone(false);
//                 oppLine.OpportunityId = newOp.Id;
//                 opli.add(oppLine);
                
//             }
//             system.debug(opli);
//             if(!opli.isempty()){
//                 insert opli; 
//             }
//             //test
//             newOppID = newOp.Id;
//         }catch(exception i){
//             Database.rollback(sp);
//             ApexPages.addMessages(i); 
//             return null; 
//         }
//         return new PageReference('/lightning/r/Opportunity/'+newOp.id+'/view'); 
//     }
// }