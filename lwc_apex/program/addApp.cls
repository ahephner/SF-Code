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
}