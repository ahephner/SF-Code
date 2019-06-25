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
   		//set to maps 
        map<string, ProductItem> prodList = new map<string, ProductItem>(); 
        //list for upserting or inserting
        List<productitem> newProduct = new List<productitem>(); 
        List<productitem> upProduct = new List<productitem>(); 
        id locationID; 
        for(productitem x:pi){
            prodList.put(x.Product2Id, x);
            locationId = x.LocationId; 
        }
        
        for(WorkOrderLineItem i: wop){
            if(prodlist.get(i.Product2Id) != null){
                productitem prod = new productitem();
                prod.Id = prodlist.get(i.Product2Id).Id; 
               	prod.Account_Name__c = i.Account__c;
                prod.QuantityOnHand = prodlist.get(i.Product2Id).QuantityOnHand + i.Quantity;
                prod.LocationId = locationID; 
                prod.Product2Id = i.Product2Id; 
                
                upProduct.add(prod); 
            }
        }
        //insert or upsert 
        return null;
    }
}