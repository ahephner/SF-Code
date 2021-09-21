public class itemTransferController {
    public static void updateTransfers(){
        Set<id> salesDocNumb = new Set<id>();
        //list for updating item transfered called below
        List<Item_Transfer__c> updatedItems = new List<Item_Transfer__c>();
        List<Item_Transfer__c> items = [Select id, Open_Order_Number__c, Sales_Document__c, Invoiced__c
                                       from Item_Transfer__c where Invoiced__c = true];
        
        if(items.size()>0){
            for(Item_Transfer__c item :items){
                salesDocNumb.add(item.Open_Order_Number__c); 
                item.Invoiced__c = false;
                updatedItems.add(item); 
            }
        }
        
        
    }
}