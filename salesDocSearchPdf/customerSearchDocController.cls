public class customerSearchDocController {
	private ApexPages.StandardController ctl {get; set;}
    public date dOne {get;set;}
    public date dTwo {get; set;}
    public string click {get;set;}
    public string cn {get; set;}
    public account acct {get;set;}
    public list<sales_doc_detail__c> call {get;set;}
    public list<sales_doc_detail__c> sale {get;set;}
    String range;
        
    public customerSearchDocController(ApexPages.StandardController ctl){
       this.ctl = ctl; 
        acct = (account)ctl.getRecord(); 
        if(acct.id != null){
            acct = [select id, customer__c from account where id = :acct.id]; 
            docList(dOne, dTwo); 
        }

    }
 	
    public list<sales_doc_detail__c> docList(date a, date b){
        list<sales_doc_detail__c> sale = new list<sales_doc_detail__c>();
        	sale = [SELECT Doc_Date__c, Extended_Price__c, Product_Name__c, Qty__c, Sales_Document__r.Name 
                    FROM Sales_Doc_Detail__c where customer__c =:acct.Customer__c and doc_date__c >= :a and doc_date__c <= :b]; 
       
        return sale; 
    }
    public pagereference getsearch(){   
        system.debug('button clicked');
        click = 'clicked'; 
        call = docList(dOne,dTwo); 
         
 	PageReference pageRef = Page.customerSalesDocsLightPDF;
  	pageRef.setRedirect(false);
  	return Page.customerSalesDocsLightPDF;
    }
    
}