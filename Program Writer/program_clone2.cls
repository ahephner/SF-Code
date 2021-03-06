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
            
            //find and insert new program
            pro = [select id, name, Account__c, CreatedById, year__c 
                from Program__c where id = :pro.Id]; 
            newPro = pro.clone(false);
            //just to check if it's an actual copy
            newPro.Name += ' Cloned'; 
            insert newPro; 
            system.debug(newPro.id);
            
            //grab area 
            if(newPro.id != null){
                id holdOver; 
            	List<Area__c> areaCopy = new List<Area__c>(); 
                List<Application__c> apps =new List<Application__c>();
                List<Application_Product__c> products = new List<Application_Product__c>(); 
                for(Area__c a1 : [Select x.id, x.name, x.Area_Acres__c, x.Area_K_Total__c,x.Area_N_Total__c,  
                                  x.Area_P_Total__c,x.Area_Sq_Feet__c,x.Date__c, x.Type__c, x.PrevID__c
                                  from area__c x where program__c = :pro.id]){
                                    holdOver = a1.id; 
                                    Area__c na = a1.clone(false);
                                    na.Program__c  = newPro.id;
                                    na.PrevID__c = a1.id; 
                                    areaCopy.add(na);
                                  }insert areaCopy; system.debug('areaCopy ->  ' + areaCopy);

                for(area__c j: areaCopy){
                for(application__c ap :[select a.Id, a.Name, a.Area__c, a.repeat__c, a.Note__c , 
             							a.Date__c,  a.Weeks_Apart__c, a.Number_of_Apps__c, App_ExernalId__c,
                                        (select Product__c, Application__c, Area_Square_Feet_M__c,  Product_Name__c,
                                            Categories__c, K__c, K_Calc__c, K_Val__c,LBS_ACRE__c,
                                            N__c,N_Val__c, Note__c, OZ_M__c,P__c, P_Calc__c,
                                            P_Val__c,Product_Category__c, Product_Size__c, name, 
                                            Product_Sub_Category__c, Rate__c, Total_Used_f__c, Units_Required__c,AP_ExernalId__c
                                            from Application_Products__r)
                                        from Application__c a where a.area__c = :j.previd__c] ){
                                            system.debug('stored ID--> '+j.Id);
                                            Application__c newApp = ap.clone(false, true); 
                                            newApp.area__c = j.Id;
											newApp.App_ExernalId__c = ap.id; 
                                            apps.add(newApp);
                                            system.debug('newApp ->  ' +newApp);
                                            
                                            for(application_product__c prod : ap.application_products__r){
                                                application_product__c prodNew = prod.clone(false, true, false);
                                                
                                                prodNew.AP_ExernalId__c = newApp.App_ExernalId__c;
                                               // prodNew.Product_Name__c = prod.product_name__c;
                                                products.add(prodNew);
                                            }
                                        }upsert apps App_ExernalID__c;
                    					 upsert products AP_ExernalId__c; 	
                    					 
                                     }
                               }
                
            newProgramId = newPro.id; 
        }
        catch(Exception e){
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
            
        }
    	return new PageReference('/lightning/r/Program__c/'+newPro.id+'/view'); 
    }
}