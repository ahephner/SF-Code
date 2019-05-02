public with sharing class openOrderController {
   //this is for list views controller
    public ApexPages.StandardSetController setCon;
    
    //say what type of list view controller we want
    public openorderController(ApexPages.StandardSetController controller){
    			setCon = controller;    
    }

    //method to call on page we extend
    public Pagereference saveTwo(){
        system.debug('in save method');
        //get the selected records by the mass edit page
        for(Open_order__c op: (List<Open_Order__c>) setCon.getSelected()){
            update op; 
        } 
        return Page.openOrdersPDF; 
    }
}