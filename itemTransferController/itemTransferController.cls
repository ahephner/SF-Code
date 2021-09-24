public class itemTransferController {
    public static void updateTransfers(){
        Set<string> salesDocNumb = new Set<string>();
        Map<String, sales_document__c> mapDocs = new Map<String, sales_document__c>(); 
        //list for updating item transfered called below
        List<Item_Transfer__c> updatedItems = new List<Item_Transfer__c>();
        List<Item_Transfer__c> items = [Select id, Open_Order_Number__c, Sales_Document__c, Invoiced__c
                                       from Item_Transfer__c where Invoiced__c = true];
        
        if(items.size()>0){
            for(Item_Transfer__c item :items){
                salesDocNumb.add(item.Open_Order_Number__c); 
            }
        }
            for(sales_document__c sd:[select id, name from sales_document__c where name in: salesDocNumb]){
                mapDocs.put(sd.name, sd);
            }
        for(Item_Transfer__c x:items){
            if(mapDocs.containsKey(x.Open_Order_Number__c)){
                id sdID = mapDocs.get(x.Open_Order_Number__c).Id; 
                x.Sales_Document__c = sdID; 
            } 
            x.Invoiced__c = false; 
            updatedItems.add(x);
        }
        try{
            database.update(updatedItems, false);
          
        }catch(exception e){
            system.debug(e);
        }
         
    }
}