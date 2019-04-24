public with sharing class lineItemController {    
    
    //private ApexPages.StandardController sc {get; set;}
    public list<quote> x;
    public List<QuoteLineItem> product;
    //public opportunity opp {get;set;}
    //public String preparedBy {get;set;}
    public lineItemController(ApexPages.StandardController controller ) {}
       //ID id = '0Q0n00000006Ts8CAE'; 
        String id = apexpages.currentpage().getparameters().get('id');
        public list<quotelineitem> getproduct(){ 
            				product = 	[select Product2.Name, quantity, UnitPrice,TotalPrice, Description,
                                          Product_Code__c from quotelineitem where quoteid = :id];
            
            for(quotelineitem y:product){
                if(y.Product_Code__c.startsWith('JDT')){
                    y.quantity = 0;
                    y.UnitPrice = y.TotalPrice; 
                }
            }return product; 
        }
        
    public list<quote> getx(){ 
           		   x= [select createddate, name, ExpirationDate,QuoteNumber, CreatedBy.Name,CreatedBy.Email,
                       GrandTotal, BillingName,shippingname,shippingstreet, shippingstate,  
                       BillingStreet, billingstate from quote where id = :id limit 1];
        
        return x; 
                         }

    
 
        
    
}