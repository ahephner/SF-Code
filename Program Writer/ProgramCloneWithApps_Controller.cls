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
            //newPro.Name = 'Cloned'; 
            insert newPro; 
            system.debug(newPro.id);
            
            //grab area 
            if(newPro.id != null){
            	List<Area__c> areaCopy = new List<Area__c>(); 
                for(Area__c a1 : [Select x.id, x.name, x.Area_Acres__c, x.Area_K_Total__c,x.Area_N_Total__c,  
                                  x.Area_P_Total__c,x.Area_Sq_Feet__c,x.Date__c, x.Type__c  
                                  from area__c x where program__c = :pro.id]){
                                    Area__c na = a1.clone(false);
                                    na.Program__c  = newPro.id;
                                      areaCopy.add(na);
                }
                insert areaCopy;
                if(areaCopy.size() > 0){
                    grabApps = true; 
                    system.debug('area copy'+ areaCopy.size()); 
                }
            }else {
                return null; 
            }
            //apps 
            system.debug(grabApps + ' grabApps Value');
            //=true not correct maybe ==
            if(grabApps = true){
                List<Application__c> appCopy = new List<Application__c>(); 
                for(Application__c ap :[select a.Id, a.Name, a.Area__c, a.repeat__c, a.Note__c , 
             							a.Date__c,  a.Weeks_Apart__c, a.Number_of_Apps__c
                                        from Application__c a where a.Program_ID__c = :pro.Id] ){
                                            Application__c work = ap.clone(false);
                                            system.debug(ap.Area__c + ' AP Area C');
                                            work.Area__c = ap.Area__c; 
                                            system.debug(work.Area__c + ' Work Area C');
                                            appcopy.add(work); 
                }insert appCopy;
                system.debug(appCopy.size() + ' appCopy Size');
            }else{return null;}
            
            
            //appProducts here 
            newProgramId = newPro.id; 
            
        }catch(Exception e){
            Database.rollback(sp);
            ApexPages.addMessages(e);
            return null;
            
        }
    	return new PageReference('/lightning/r/Program__c/'+newPro.id+'/view'); 
    }
}