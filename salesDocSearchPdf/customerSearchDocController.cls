public class customerSearchDocController {
	private ApexPages.StandardController ctl {get; set;}
    public date dOne {get;set;}
    public date dTwo {get; set;}
    public account acct {get;set;}
    public list<sales_doc_detail__c> call {get;set;}
    public list<sales_doc_detail__c> sale {get;set;}
    public list<Sales_Document__c> doc_c {get;set;}
    public list<Sales_Document__c> doc_s {get;set;}
        
    public customerSearchDocController(ApexPages.StandardController ctl){
        this.ctl = ctl; 
        this.dOne = date.newInstance(2017, 10, 01);
        this.dTwo = date.today().addDays(-365); 
        acct = (account)ctl.getRecord(); 
        if(acct.id != null){
            acct = [select id, customer__c, Customer_Name__c from account where id = :acct.id]; 
            head(dOne, dTwo); 
            docList(dOne, dTwo); 
        }

    }
 	
    public list<sales_doc_detail__c> docList(date a, date b){
        //list<sales_doc_detail__c> sale = new list<sales_doc_detail__c>();
        	sale = [SELECT Sales_Document__c, Extended_Price__c, Product_Name__c, Qty__c, unit_price__c
                    FROM Sales_Doc_Detail__c where customer__c =:acct.Customer__c and doc_date__c >= :a and doc_date__c <= :b order by doc_date__c asc]; 
       			
        	
        return sale; 
    }
    public list<Sales_Document__c> head(date a, date b){
        doc_s = [select id, name, Doc_Date__c, Product_Sub_Total__c
                 from sales_document__c where Customer__c = :acct.Id and doc_date__c >= :a and doc_date__c <= :b order by doc_date__c asc ];
        return doc_s; 
    }
    public pagereference getsearch(){   
    	doc_c = head(dOne, dTwo);    
        call = docList(dOne,dTwo); 
         
 	PageReference pageRef = Page.customerSalesDocsLightPDF;
  	pageRef.setRedirect(false);
  	return Page.customerSalesDocsLightPDF;
    }
    
}