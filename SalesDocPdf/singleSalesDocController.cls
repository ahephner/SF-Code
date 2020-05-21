public class singleSalesDocController {
//private ApexPages.StandardController sc {get; set;}
    public list<Sales_Document__c> head;
    public List<Sales_Doc_Detail__c> detail;
    public object q;
    public string feeLinkTotal {get;set;}
    public string linkTotal {get;set;}
    //public opportunity opp {get;set;}
    //public String preparedBy {get;set;}
    public singleSalesDocController(ApexPages.StandardController controller ) {}
       ID id = 'a0E2h0000008p2dEAA'; 
       //String id = apexpages.currentpage().getparameters().get('id');
        public list<Sales_Doc_Detail__c> getdetail(){ 
                    detail =   [select Product_Name__c, Qty__c, Unit_Price__c,Extended_Price__c,
                                Product__r.name from Sales_Doc_Detail__c where Sales_Document__c = :id];
	
            		return detail;
            //for(Sales_Doc_Detail__c y:detail){
              //  if(y.Product__r.name.startsWith('JDT')){
                   // y.Qty__c = 0;
                //    y.Unit_Price__c = y.Extended_Price__c; 
                //}
            //} 
        }
        
    public list<Sales_Document__c> gethead(){ 
                  head= [select Doc_Date__c, Sales_Rep__r.name, Sales_Rep__r.Email__c, Sales_Rep__r.Mobile__c, name, Doc_Type__c, Number_of_Payments__c,
                         		customer__r.S_Account__c, Line_Total__c,Replaced_by_Credit_Rebill_Num__c,Replaced_by_Credit_Rebill__c,Due_Date__c,
                         		Tax_Amount__c, Freight_Amount__c, Doc_Amount__c, Payment_Terms__c, Billing_Company__c, Customer__r.Customer__c,
                         	    Billing_Street__c, Billing_State__c, Billing_Zip_Code__c, Billing_City__c, Ship_Type__c,Cust_PO_Num__c
                         		from Sales_Document__c where id = :id limit 1]; 
        		
        		//total amount with 2% added in for paying by credit card 	
            	double cardCharge = ((head[0].Doc_Amount__c *.02) + head[0].Doc_Amount__c);
            	//non charge link
            	double noCharge = head[0].Doc_Amount__c; 	
        		//fee link
        		feeLinkTotal = 'https://advancedturf.securepayments.cardpointe.com/pay?total='+cardCharge+'&paymentType=cc&invoice='+head[0].name+'&customerId=' +head[0].Customer__r.Customer__c; 
        		//free link
        		linkTotal = 'https://advancedturf.securepayments.cardpointe.com/pay?total='+noCharge+'&paymentType=cc&invoice='+head[0].name+'&customerId=' +head[0].Customer__r.Customer__c;
       			
        		return head; 
    }
    
    public object getq(){
        AggregateResult [] result = [select sum(qty__c)ttt from Sales_Doc_Detail__c where Sales_Document__c = :id];
       q = result[0].get('ttt');   
       return q;
    }

}