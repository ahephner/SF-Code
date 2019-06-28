public class workOrderProductsToLocation {
//need an extension
    private ApexPages.StandardController controller{get;set;}
    public workorder wo {get;set;}
    
    public workOrderProductsToLocation(ApexPages.StandardController controller){
        this.controller = controller; 
        
        wo = (WorkOrder)controller.getRecord();
        //query fields
        if(wo != null){
            wo = [select id, accountid, Add_Product_to_Location__c from workorder
                 where id =:wo.Id]; 
        }
    }
    
    public PageReference send(){
        //Rollback point
        Savepoint sp = Database.setSavepoint();
        system.debug(wo.Add_Product_to_Location__c);
        wo.Add_Product_to_Location__c = True;
        system.debug('after ' +wo.Add_Product_to_Location__c);
        ID nID = [Select Id from location where Parent_Account_ID__c = :wo.AccountId].id;
        List<WorkOrderLineItem> wop = [SELECT Account__c, Product2Id, Quantity, WorkOrder.AccountId FROM WorkOrderLineItem where  WorkOrderId = :wo.Id ];
        list<ProductItem> pi = [Select ID, Account_Name__c,LocationId,Product2Id,QuantityOnHand from productitem 
                        where account_name__c = :wo.AccountId];
        system.debug(pi);
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
                productitem prod = new productitem(
                Id = prodlist.get(i.Product2Id).Id, 
               	Account_Name__c = i.Account__c,
                QuantityOnHand = prodlist.get(i.Product2Id).QuantityOnHand + i.Quantity,
                locationID = locationID,
                Product2Id = i.Product2Id
       );
                upProduct.add(prod); 
            }else{
                productitem np = new productitem();
                np.Account_Name__c = i.Account__c;
                np.QuantityOnHand = i.Quantity;
                np.Product2Id = i.Product2Id;
                np.LocationId = nID;
                system.debug(locationID);
                newProduct.add(np);
            }
         }
        //insert or upsert 
        try{
            if(upProduct.size()>0 || newproduct.size()>0){
            update upProduct; 
            insert newproduct;
            update wo; 
                
            }
 
        }catch(exception e){
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null; 
        }
 
        return new PageReference('/lightning/r/WorkOrder/'+wo.id+'/view');
    }
}