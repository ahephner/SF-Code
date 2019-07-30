public class internalCustomerSearchDocController {
	private ApexPages.StandardController ctl {get; set;}
    public date dOne {get;set;}
    public date dTwo {get; set;}
    public account acct {get;set;}
    public list<sales_doc_detail__c> call {get;set;}
    public list<sales_doc_detail__c> sale {get;set;}
    public list<Sales_Document__c> doc_c {get;set;}
    public list<Sales_Document__c> doc_s {get;set;}
    public object total {get;set;}   
    public object total_sale {get;set;} 
    
    public internalCustomerSearchDocController(ApexPages.StandardController ctl){
        this.ctl = ctl; 
        this.dOne = date.newInstance(2017, 10, 01);
        this.dTwo = date.today().addDays(-365); 
        acct = (account)ctl.getRecord(); 
        if(acct.id != null ){
            acct = [select id, customer__c, Customer_Name__c from account where id = :acct.id]; 
            head(dOne, dTwo); 
            docList(dOne, dTwo); 
            sale(dONe, dTwo); 
        //system.debug('in extension');
          //  system.debug(head(dOne, dTwo));
        }
    }
    
        public list<sales_doc_detail__c> docList(date a, date b){
        //dont get tax, shipping what else ask tracie 
        	sale = [SELECT Sales_Document__c, Extended_Price__c, Product_Name__c, Qty__c, unit_price__c, margin__c, gross_profit__c
                    FROM Sales_Doc_Detail__c where customer__c =:acct.Customer__c and doc_date__c >= :a and doc_date__c <= :b order by doc_date__c asc]; 
       			
        return sale; 
    }
    public list<Sales_Document__c> head(date a, date b){
        doc_s = [select id, name, Doc_Date__c, Product_Sub_Total__c
                 from sales_document__c where Customer__c = :acct.Id and doc_date__c >= :a and doc_date__c <= :b order by doc_date__c asc ];
        return doc_s; 
    }
    public object sale(date a, date b){
       AggregateResult [] result = [select sum(Product_Sub_Total__c)ttt from sales_document__c 
                                    where Customer__c = :acct.Id and doc_date__c >= :a and doc_date__c <= :b ];
       total_sale = result[0].get('ttt');   
       return total_sale; 
    }
    public pagereference getsearch(){   
    	doc_c = head(dOne, dTwo);    
        call = docList(dOne,dTwo); 
        total = sale(dONe, dTwo);  
 	PageReference pageRef = Page.internalCustomerSearchPDF;
  	pageRef.setRedirect(true);
  	return Page.internalCustomerSearchPDF;
    }
}