public with sharing class lineItemController {    
    
    //private ApexPages.StandardController sc {get; set;}
    public quote x;
    public List<QuoteLineItem> product;
    public opportunity opp {get;set;}
    public String preparedBy {get;set;}
//hardcoded for testing
        ID id = '0Q0n00000006Ts8CAE'; 
       
        public list<quotelineitem> getproduct(){ 
            				product = 	[select Product2.Name, quantity, UnitPrice,TotalPrice, Description,
                                          Product_Code__c from quotelineitem where quoteid = :id];
            
            for(quotelineitem y:product){
                if(y.Product_Code__c.startsWith('JDT')){
                    y.UnitPrice = 0;
                }
            }return product; 
        }
        
    public quote getx(){ 
           		   x= [select createddate, name, ExpirationDate,QuoteNumber, CreatedById, 
                     GrandTotal, BillingName, BillingAddress from quote where id ='0Q0n00000006Ts8CAE'];
        	
        return x; 
                         }

    
 
        
    
}