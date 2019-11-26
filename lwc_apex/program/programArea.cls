    //below is for all area pdf
    public list<area__c> areas {get;set;}
    public List<Application__c> aApplications {get;set;}
    public List<Application_Product__c> aApplicationProducts {get;set;}

      public pageReference areaSummary(){
        areas = [select Area_Acres__c, Area_K_Total__c, Area_N_Total__c, Area_P_Total__c, Area_Sq_Feet__c, Date__c, Name, 
                Program__c, Type__c, OwnerId
                from Area__c where program__c =: pro.id];
       
        List<Id> areaIds = new List<Id>(); 
       
        for(Area__c a : areas){
            areaIds.add(a.Id); 
        }
        aApplications = [select Application_K_Total__c, Application_N_Total__c, Application_P_Total__c, Area__c, Month__c, Week__c, Name, Date__c 
                        from Application__c where Area__c in :areaIds order by Date__c Asc ];
                        
        List<Id> appIds = new List<Id>();
                        
        for(Application__c app : aApplications) {
            appIds.add(app.Id);
        }
                        
        aApplicationProducts = [select Area_Square_Feet_M__c, Categories__c, K__c, LBS_ACRE__c, N__c, OZ_M__c, P__c, Product__c, Total_Used_f__c,
                                Product__r.Name, Product_Name__c, Application__c, Note__c, Note_Other__c, 
                                N_Val__c, P_Val__c, K_Val__c 
                                from Application_Product__c where Application__c IN: appIds];
        return null; 
    }