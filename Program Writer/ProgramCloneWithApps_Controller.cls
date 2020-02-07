public class ProgramCloneWithApps_Controller {
     //added an instance variable for the standard controller
        private ApexPages.StandardController controller {get; set;}
    
         // add the instance for the variables being passed by id on the url
        private Program__c pro {get;set;}
    	private Area__c area{get;set;}
    	private Application__c apps {get;set;}
        // set the id of the record that is created -- ONLY USED BY THE TEST CLASS
        public ID newProgramId {get;set;}
    
        // initialize the controller
        public ProgramCloneWithApps_Controller(ApexPages.StandardController controller) {
    
            //initialize the stanrdard controller
            this.controller = controller;
            // load the current record
            pro = (Program__c)controller.getRecord();
    		//apps = (Application__c)controller.getRecord();
        }
    
    public PageReference cloneProgram() {
        
        Savepoint sp = Database.setSavepoint();
        //new program base
        Program__c newPro; 
       
        try{
            //flow control 
            //Hoisting out of if's not like js 
            boolean grabApps = false; 
            system.debug('hey there how are you?');
            //find and insert new program
            pro = [select id, name, Account__c, CreatedById, year__c 
                from Program__c where id = :pro.Id]; 
            newPro = pro.clone(false);
            //just to check if it's an actual copy

            newPro.Name += ' Cloned'; 

            insert newPro; 
            //system.debug(newPro.id);
            
            //grab area 
            if(newPro.id != null){

                system.debug('inside the if newpro <> null');
            	List<Area__c> areaCopy = new List<Area__c>(); 
                List<Application__c> apps =new List<Application__c>();
                

                for(Area__c a1 : [Select x.id, x.name, x.Area_Acres__c, x.Area_K_Total__c,x.Area_N_Total__c,  
                                  x.Area_P_Total__c,x.Area_Sq_Feet__c,x.Date__c, x.Type__c, x.PrevID__c 
                                  from area__c x where program__c = :pro.id]){ 
                                    Area__c na = a1.clone(false);
                                    na.Program__c  = newPro.id;
                                    na.PrevID__c = a1.id; 
                                    areaCopy.add(na);
                                  }insert areaCopy; 
                				   //system.debug('areaCopy ->  ' + areaCopy);

                for(area__c j: areaCopy){
                    for(application__c ap :[select a.Id, a.Name, a.Area__c, a.repeat__c, a.Note__c , a.Clone__c, 
                                            a.Date__c,  a.Weeks_Apart__c, a.Number_of_Apps__c, a.Prev_App_Id__c
                                            from Application__c a where a.area__c = :j.previd__c] ){
                                        //new app info here
                                               // system.debug('stored ID--> '+j.Id);
                                                Application__c newApp = ap.clone(false); 
                                                newApp.area__c = j.Id;
                                                newApp.Prev_App_Id__c = ap.Id; 
                                                newApp.Clone__c = True; 
                                                apps.add(newApp);
                                     			//system.debug(newApp);      
                                            } 
                    					 //upsert apps 
                                         }upsert apps;
                                          system.debug('apps ->  ' +apps);  
                               }
            //testing purposes    
            newProgramId = newPro.id; 
        }
        catch(Exception e){

            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
            
        }
    	return new PageReference('/lightning/r/Program__c/'+newPro.id+'/view'); 
    }
    
    //This gets the products for the lwc appCloneModal
    @AuraEnabled(Cacheable=true)
    public static List<Application_Product__c> cloneProducts(string app){
        List<Application_Product__c> prods = [select id, product__c, Product_Name__c,Application__c, Application__r.Name,Report_Rate__c, 
                                              Application__r.Date__c, Unit_Area__c, Rate2__c, area__c, Note__c, Unit_Price__c,
                                              Total_Price__c, Units_Required__c,Product_Size__c, Application__r.Area__c,
                                              Application__r.Area__r.Area_Sq_Feet__c, Margin__c, Product_Cost__c from application_product__c where application__c =: app];
        //system.debug('here are the products ' +prods);
        return prods;
    }
}