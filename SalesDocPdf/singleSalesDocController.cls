public class singleSalesDocController {
//private ApexPages.StandardController sc {get; set;}
    public list<Sales_Document__c> head;
    public List<Sales_Doc_Detail__c> detail;
    public object q;
    //public opportunity opp {get;set;}
    //public String preparedBy {get;set;}
    public singleSalesDocController(ApexPages.StandardController controller ) {}
      // ID id = 'a0E2h0000008nYLEAY'; 
       String id = apexpages.currentpage().getparameters().get('id');
        public list<Sales_Doc_Detail__c> getdetail(){ 
                    detail =   [select Product_Name__c, Qty__c, Unit_Price__c,Extended_Price__c,
                                Product__r.name from Sales_Doc_Detail__c where Sales_Document__c = :id];
            
            for(Sales_Doc_Detail__c y:detail){
                if(y.Product__r.name.startsWith('JDT')){
                   // y.Qty__c = 0;
                    y.Unit_Price__c = y.Extended_Price__c; 
                }
            }return detail; 
        }
        
    public list<Sales_Document__c> gethead(){ 
                  head= [select Doc_Date__c, Sales_Rep__r.name, Sales_Rep__r.Email__c, Sales_Rep__r.Mobile__c, name, Number_of_Payments__c,
                         		customer__r.S_Account__c, Line_Total__c,Replaced_by_Credit_Rebill_Num__c,Replaced_by_Credit_Rebill__c,Due_Date__c,
                         		Tax_Amount__c, Freight_Amount__c, Doc_Amount__c, Payment_Terms__c, Customer__r.name  from Sales_Document__c where id = :id 
                         		 limit 1]; 
        return head; 
                         }
    public object getq(){
        AggregateResult [] result = [select sum(qty__c)ttt from Sales_Doc_Detail__c where Sales_Document__c = :id];
       q = result[0].get('ttt');   
       return q;
    }

}