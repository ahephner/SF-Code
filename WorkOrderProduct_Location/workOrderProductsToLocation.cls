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
        //select the work order items. We do not care about services and shipping. We can adjust what gets sent here
        List<WorkOrderLineItem> wop = [SELECT Account__c, Product2Id, Quantity, WorkOrder.AccountId FROM WorkOrderLineItem 
                                       where  WorkOrderId = :wo.Id and (not product_code__c like 'jdt%') and(not product_code__c like '%shipping%')];
        //get all the productitems at that location 
        list<ProductItem> pi = [Select ID, Account_Name__c,LocationId,Product2Id,QuantityOnHand from productitem 
                        		where account_name__c = :wo.AccountId ];
        system.debug('product items ' +pi);
   		//set to maps 
        map<string, ProductItem> prodList = new map<string, ProductItem>(); 
        //list for upserting or inserting
        List<productitem> newProduct = new List<productitem>(); 
        List<productitem> upProduct = new List<productitem>(); 
        id locationID; 
        //put the current products in a map to filter below off
        for(productitem x:pi){
            prodList.put(x.Product2Id, x);
            locationId = x.LocationId; 
           
        }
        //we can only have one line item for a product. We see if the product is already there. If it is then add the new amount to the line items
        //otherwise create a new product line item.  
                for(WorkOrderLineItem i: wop){
            if(prodlist.get(i.Product2Id) != null){
                productitem prod = new productitem(
                Id = prodlist.get(i.Product2Id).Id, 
               	Account_Name__c = i.Account__c,
                QuantityOnHand = prodlist.get(i.Product2Id).QuantityOnHand + i.Quantity,
                locationID = locationID,
                Product2Id = i.Product2Id
       );
                system.debug('here is prod ' + prod);
                upProduct.add(prod); 
                system.debug(prod);
                system.debug('current product id ' +prodlist.get(i.Product2Id).Id);
            }else{
                productitem np = new productitem();
                np.Account_Name__c = i.Account__c;
                np.QuantityOnHand = i.Quantity;
                np.Product2Id = i.Product2Id;
                np.LocationId = nID;
                system.debug(locationID);
                newProduct.add(np);
                system.debug(newProduct);
            }
         }
        //insert or upsert 
        try{
            if(upProduct.size()>0 || newproduct.size()>0){
                system.debug(upProduct.size());
                system.debug('newPrdouct '+ newproduct.size());
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