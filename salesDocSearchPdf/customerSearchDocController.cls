public class customerSearchDocController {
	private ApexPages.StandardController ctl {get; set;}
    public date dOne {get;set;}
    public date dTwo {get; set;}
    public string click {get;set;}
    public string cn {get; set;}
    public account acct {get;set;}
    public list<Sales_Doc_Detail__c> call;
    
    String range;
        
    public customerSearchDocController(ApexPages.StandardController ctl){
       this.ctl = ctl; 
        acct = (account)ctl.getRecord(); 
        if(acct.id != null){
            acct = [select id, customer__c from account where id = :acct.id]; 
        }
    }
 	
    public pagereference getsearch(){   
        system.debug('button clicked');
        click = 'clicked'; 
        date cleanOne = date.valueOf(dOne); 
        date cleanTwo = date.valueOf(dTwo); 
        list<Sales_Doc_Detail__c> call = [SELECT Doc_Date__c, Extended_Price__c, Product_Name__c, Qty__c, Sales_Document__r.Name 
                                          FROM Sales_Doc_Detail__c where customer__c =:acct.Customer__c and doc_date__c >= :dOne and doc_date__c <= :dTwo];
        system.debug(call);
        return null; 
    }
    
}