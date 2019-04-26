public with sharing class openOrderSearch {
	
    private ApexPages.StandardSetController sc;
    public list<open_order__c> x;
    public user t; 
    public date dt  {get;set;}
    public string loc {get;set;}
    String[] ship = new String[]{}; 

    
     public openOrderSearch(ApexPages.StandardSetController con){
        //add reference to standard controller
       sc = con; 
    }
    string id = userinfo.getUserId(); 
    
    public list<open_order__c> getx(){
        x =[Select Name, Sales_Rep__r.name, Customer__r.name, Doc_Amount__c, Doc_Date__c
                ,Req_Ship_Date__c, Order_Note__c from Open_Order__c where location__r.regional_manager__c =: id ];
        return x; 
    }
    
    public void toPage(){
        system.debug(dt); 
        dt = system.Date.today(); 
        system.debug(loc);
        loc = '';
        system.debug(ship);
         
    }
    public void test(){system.debug('hello'); system.debug(loc);}
    public List<selectOption>  getshiptypes(){
        List<selectOption> shiptypes = new List<selectOption>();
            shiptypes.add(New SelectOption('DS', 'DS' ));
            shiptypes.add(New SelectOption('FG', 'FG' ));
            shiptypes.add(New SelectOption('LT', 'LT' ));
            shiptypes.add(New SelectOption('T1', 'T1' ));
            shiptypes.add(New SelectOption('T4', 'T4' ));
        	return shiptypes; 
        }
     
    
    public string getfoo(){
        return 'foo-one';
    }

}