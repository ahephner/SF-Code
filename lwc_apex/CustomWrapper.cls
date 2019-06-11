public with sharing class CustomWrapper {
//to define inner wrappers in here
////https://github.com/trailheadapps/lwc-recipes/blob/master/force-app/main/default/classes/CustomWrapper.cls
    @AuraEnabled
    public Date one {get; set;}
    @AuraEnabled
    public Date two {get; set;}
	@AuraEnabled
    public Boolean check {get; set;}
    @AuraEnabled
    public String prodName {get; set;}
    @AuraEnabled
    public String custNum {get;set;}
}