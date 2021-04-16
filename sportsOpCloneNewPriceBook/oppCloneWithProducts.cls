public class oppCloneWithProducts {
    
    private ApexPages.StandardController controller {get; set;}
    
    private Opportunity opp {get; set;}
    //private Product2 prods {get; set;}
    //set the id of the record that is created --Only used by Test Class
    public ID newOppID {get; set;}
    private string nonActiveItem = '';
    private string sportsPriceBookId = '01s17000003ccClAAI'; 
    //production below
    //private string sportsPriceBookId = '01s2M000008dTCeQAM';

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
       Id sportsBook = [select id from pricebook2 where name = 'Sports Turf'].Id; 
         
        try{
         opp = [SELECT Id, Name, AccountId, CloseDate, Job_Type__c, StageName,  Sales_Rep__r.OwnerId, 
                RecordType.Id, Contact__c, Service_Address__c,pricebook2.id,Type, Target_Area__c,
                Target_Start_Date__c, description FROM Opportunity where id = :opp.Id]; 
  
            newOp = opp.clone(false);
            
            newOp.Name += ' Cloned';
            newOp.StageName = 'Estimate(10%)';
            newOp.Pricebook2Id = sportsBook;
         //   newOp.CloseDate = cd;  
            insert newOp; 
            system.debug('here new opp -> ' +newOp);
           //test
            newOppID = newOp.Id;
            oppCloneHelper.pbeEntries(opp.Id, newOp.id); 

            
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