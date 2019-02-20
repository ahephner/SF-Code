public class lineItem {    
    
    private ApexPages.StandardController sc {get; set;}
    public quote quote {get;set;}
    public List<QuoteLineItem> product {get;set;}
    public opportunity opp {get;set;}
    public String preparedBy {get;set;}
	
    public lineItem(ApexPages.StandardController sc){
    		this.sc = sc; 
    }
 
    public PageReference li(){
        String id = apexpages.currentpage().getparameters().get('id'); 
       
        list<quotelineitem> product = [select Product2Id, quantity, UnitPrice, Description
                                      from quotelineitem where quoteid = :id];
        quote quote =[select createddate, name, ExpirationDate,QuoteNumber, CreatedById, 
                     GrandTotal, BillingName, BillingAddress from quote where id =:id];
        
         return new PageReference('/lightning/r/Quote/0Q0n00000006Ts8CAE/view'); 
    }
        
    
}