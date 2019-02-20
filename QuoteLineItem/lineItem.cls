public class lineItem {    
    
    private ApexPages.StandardController sc {get; set;}
    public quote quote {get;set;}
    public List<QuoteLineItem> product {get;set;}
    public opportunity opp {get;set;}
    public String preparedBy {get;set;}
//this will be deleted later we are only using it as a standard controller for testing in app 	
    public lineItem(ApexPages.StandardController sc){
    		this.sc = sc; 
    }
 //future class only 
    public PageReference li(){
        String id = apexpages.currentpage().getparameters().get('id'); 
       
        list<quotelineitem> product = [select Product2.Name, quantity, UnitPrice, Description
                                      from quotelineitem where quoteid = :id];
        quote quote =[select createddate, name, ExpirationDate,QuoteNumber, CreatedById, 
                     GrandTotal, BillingName, BillingAddress from quote where id =:id];
        for(quotelineitem x:product){system.debug('here is the products --> ' +x.Product2.Name);}
         return new PageReference('/lightning/r/Quote/0Q0n00000006Ts8CAE/view'); 
    }
        
    
}