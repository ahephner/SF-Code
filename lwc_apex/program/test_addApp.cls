public with sharing class addApp {
  @AuraEnabled 
    public static Application__c addApplication(appWrapper wrapper){
        Application__c app = new Application__c(); 
        app.Name = wrapper.appName; 
        app.Area__c = wrapper.appArea;
        app.Date__c = date.valueof(wrapper.appDate); 
        insert app; 
        return app; 
    }
    @AuraEnabled
    public static List<Application_Product__c> addProducts(string products){
         List<Application_Product__c> prodList = new List<Application_Product__c>(); 
        JSONParser parser = JSON.createParser(products); 
        while(parser.nextToken() != null){
            if(parser.getCurrentToken() == JSONToken.START_ARRAY){
                while(parser.nextToken() != null){
                    //system.debug('current name' + parser.getCurrentName() + ' current token' + parser.getCurrentToken());
                    if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                        application_product__c ap = new application_product__c();
                        application_product__c temp = (application_product__c)parser.readValueAs(application_product__c.class);
                        system.debug('temp ' + temp);
                        if(temp.Application__c != null){
                           //ap.Id = temp.Id;
                           ap.Product__c = temp.product__c;
                           ap.Application__c = temp.Application__c; 	
                           ap.OZ_M__c = temp.OZ_M__c;
                           ap.Note__c = temp.Note__c; 
                            //system.debug('product id '+ ap.Product__c);
                            prodList.add(ap);
                        }
                       
                        parser.skipChildren();
                    }
                }
            }   
        } 
        if(!prodList.isempty()){
            insert prodList; 
        }
        return null;  
    }
    //Updates applications
    @AuraEnabled 
    public static Application__c updateApplication(appWrapper wrapper, string id){
        Application__c app = [select Name, Area__c, Date__c from Application__c where id =: id]; 
        
        if(app.Name	!= wrapper.appName || app.date__c != wrapper.appDate){
            app.Name = wrapper.appName;
            app.Date__c = wrapper.appDate; 
        }
        update(app); 
        return app; 
        
    }
    @AuraEnabled
    public static List<Application_Product__c> updateProducts(string products){
         List<Application_Product__c> prodList = new List<Application_Product__c>(); 
        JSONParser parser = JSON.createParser(products); 
        while(parser.nextToken() != null){
            if(parser.getCurrentToken() == JSONToken.START_ARRAY){
                while(parser.nextToken() != null){
                    //system.debug('current name' + parser.getCurrentName() + ' current token' + parser.getCurrentToken());
                    if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                        application_product__c ap = new application_product__c();
                        application_product__c temp = (application_product__c)parser.readValueAs(application_product__c.class);
                        system.debug('temp ' + temp);
                        if(temp.Application__c != null){
                           ap.Id = temp.Id;
                           //ap.Product__c = temp.product__c;
                           //ap.Application__c = temp.Application__c; 	
                           ap.OZ_M__c = temp.OZ_M__c;
                           ap.Note__c = temp.Note__c; 
                            system.debug('product id '+ ap.Id);
                            prodList.add(ap);
                        }
                       
                        parser.skipChildren();
                    }
                }
            }   
        } 
        if(!prodList.isempty()){
            upsert prodList; 
        }
        return null;  
    }
    
}