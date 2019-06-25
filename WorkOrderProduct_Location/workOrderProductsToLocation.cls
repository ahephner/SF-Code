public class workOrderProductsToLocation {
//need an extension
    private ApexPages.StandardController controller{get;set;}
    public workorder wo {get;set;}
    public workOrderProductsToLocation(ApexPages.StandardController controller){
        this.controller = controller; 
        
        wo = (WorkOrder)controller.getRecord();
        //query fields
        if(wo != null){
            wo = [select id, accountid from workorder
                 where id =:wo.Id]; 
        }
    }
    
    public PageReference send(){
        List<WorkOrderLineItem> wop = [SELECT Account__c, Product2Id, Quantity, WorkOrder.AccountId FROM WorkOrderLineItem where  WorkOrderId = :wo.Id ];
        list<ProductItem> pi = [Select ID, Account_Name__c,LocationId,Product2Id,QuantityOnHand from productitem 
                        where account_name__c = :wo.AccountId];
        system.debug(wop);
        system.debug('here is location info' + pi);
        return null;
    }
}