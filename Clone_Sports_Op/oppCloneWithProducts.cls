public class oppCloneWithProducts {
    
    private ApexPages.StandardController controller {get; set;}
    
    private Opportunity opp {get; set;}
    //private Product2 prods {get; set;}
    //set the id of the record that is created --Only used by Test Class
    public ID newOppID {get; set;}
    
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
        Date cd = System.today() + 7; 
        
        try{
         opp = [SELECT Id, Name, AccountId, CloseDate, Job_Type__c, StageName, RecordType.Id, 
                pricebook2.id  
                FROM Opportunity where id = :opp.Id]; 
            
            newOp = opp.clone(false);
            
            newOp.Name += ' Cloned';
            newOp.StageName = 'Estimate(10%)';
            newOp.CloseDate = cd;  
            insert newOp; 
            system.debug('here new opp -> ' +newOp);
            Quote q = new Quote(); 
            
            q.name = newOp.Name;
            q.OpportunityId = newOp.Id; 
            insert q; 
            newOp.SyncedQuoteId = q.Id; 
            update newOp; 

        }catch(exception e){
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
            
        }try{
            system.debug('second try newopID ----> '+newop.ID);
            List<OpportunityLineItem> lineItems = [SELECT opportunityid, product2id, unitprice, quantity,
                                  				   rate__c, listprice
                                  				   from opportunitylineitem where opportunityid = :opp.Id];
            for(OpportunityLineItem x : lineItems){
                opportunitylineitem oppLine = x.clone(false);
                oppLine.OpportunityId = newOp.Id;
                opli.add(oppLine);
                
            }
            system.debug(opli);
            if(opli.size()>1){
                insert opli; 
            }
            //test
            newOppID = newOp.Id;
        }catch(exception i){
            Database.rollback(sp);
            ApexPages.addMessages(i); 
            return null; 
        }
        return new PageReference('/lightning/r/Opportunity/'+newOp.id+'/view'); 
    }
}