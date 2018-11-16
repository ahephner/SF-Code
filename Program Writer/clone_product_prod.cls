//for reference only this is current production code on 11/16/18

public class ApplicationCloneWithProducts_Controller {

    //added an instance variable for the standard controller
    private ApexPages.StandardController controller {get; set;}
     // add the instance for the variables being passed by id on the url
    private Application__c app {get;set;}
    // set the id of the record that is created -- ONLY USED BY THE TEST CLASS
    public ID newRecordId {get;set;}

    // initialize the controller
    public ApplicationCloneWithProducts_Controller(ApexPages.StandardController controller) {

        //initialize the stanrdard controller
        this.controller = controller;
        // load the current record
        app = (Application__c)controller.getRecord();

    }

    // method called from the VF's action attribute to clone the application
    public PageReference cloneWithItems() {

         // setup the save point for rollback
         Savepoint sp = Database.setSavepoint();
         Application__c newApp;

         try {

              //copy the purchase order - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE
             app = [select Id, Name, Area__c, Month__c , Week__c , Note__c , Date__c from Application__c where id = :app.id];
             newApp = app.clone(false);
             insert newApp;

             // set the id of the new po created for testing
               newRecordId = newApp.id;

             // copy over the line items - ONLY INCLUDE THE FIELDS YOU WANT TO CLONE
             List<Application_Product__c> items = new List<Application_Product__c>();
             for (Application_Product__c ap1 : [Select ap.Id, ap.Product__c, ap.Note__c, ap.Note_Other__c, ap.OZ_M__c, ap.LBS_ACRE__c From Application_Product__c ap where Application__c = :app.id]) {
                  Application_Product__c newAP = ap1.clone(false);
                  newAP.Application__c = newApp.id;
                  items.add(newAP);
             }
             insert items;

         } catch (Exception e){
             // roll everything back in case of error
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
         }

        return new PageReference('/'+newApp.id+'/e?retURL=%2F'+newApp.id);
    }
}