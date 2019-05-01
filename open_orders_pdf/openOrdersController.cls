public with sharing class openOrderController {
   
    public ApexPages.StandardSetController setCon;
    
    public openorderController(ApexPages.StandardSetController controller){
    			setCon = controller;    
    }

    
    public Pagereference saveTwo(){
        system.debug('in save method');
        for(Open_order__c op: (List<Open_Order__c>) setCon.getSelected()){
            update op; 
        } 
        return Page.openOrdersPDF; 
    }
}