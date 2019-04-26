public with sharing class openOrderSearch {
	
    public list<open_order__c> x;
    public user t; 
    
    public openOrderSearch(ApexPages.StandardSetController con){}
    string id = userinfo.getUserId(); 
    
    public list<open_order__c> getx(){
        x =[Select Name, Sales_Rep__r.name, Customer__r.name, Doc_Amount__c, Doc_Date__c
                ,Req_Ship_Date__c, Order_Note__c from Open_Order__c where location__r.regional_manager__c =: id ];
        return x; 
    }
    public string getfoo(){
        return 'foo-one';
    }

}