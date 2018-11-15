public class ProgramCloneWithApps_Controller {
     //added an instance variable for the standard controller
        private ApexPages.StandardController controller {get; set;}
    
         // add the instance for the variables being passed by id on the url
        private Program__c pro {get;set;}
        // set the id of the record that is created -- ONLY USED BY THE TEST CLASS
        public ID newRecordId {get;set;}
    
        // initialize the controller
        public ProgramCloneWithApps_Controller(ApexPages.StandardController controller) {
    
            //initialize the stanrdard controller
            this.controller = controller;
            // load the current record
            pro = (Program__c)controller.getRecord();
    
        }
    
    public PageReference cloneProgram() {
    	return new PageReference('/lightning/r/Program__c/a0J3C000000SydqUAC/view'); 
    }
}