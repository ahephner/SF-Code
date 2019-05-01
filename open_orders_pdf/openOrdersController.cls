public with sharing class openOrderController {
   
    public ApexPages.StandardSetController setCon{
        get{
            if(setCon == null){
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                [Select Name, Sales_Rep__r.name, Customer__r.name, Doc_Amount__c, Doc_Date__c
                ,Req_Ship_Date__c, Order_Note__c from Open_Order__c]));
            }
            return setCon;
        }
        set;
    }
    public openorderController(ApexPages.StandardSetController controller){
        
    }
    public List<Open_Order__c> getOrders(){
        return (List<Open_Order__c>) setCon.getRecords(); 
    }
    
    public Pagereference saveTwo(){
        system.debug('in save method');
        for(Open_order__c op: (List<Open_Order__c>) setCon.getSelected()){
            system.debug('here ' +op.name);
        } 
        return Page.openOrdersPDF; 
    }
}