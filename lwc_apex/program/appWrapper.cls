public with sharing class appWrapper {
	@AuraEnabled
    public String appName {get;set;} 
    @AuraEnabled
    public Date appDate {get;set;} 
    @AuraEnabled
    public String appArea {get;set;} 
    
}