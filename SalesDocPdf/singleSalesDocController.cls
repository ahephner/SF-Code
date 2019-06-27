public class singleSalesDocController {
//private ApexPages.StandardController sc {get; set;}
    public list<Sales_Document__c> doc;
    public List<Sales_Doc_Detail__c> head;
    //public opportunity opp {get;set;}
    //public String preparedBy {get;set;}
    public singleSalesDocController(ApexPages.StandardController controller ) {}
       //ID id = '0Q0n00000006Ts8CAE'; 
        String id = apexpages.currentpage().getparameters().get('id');
        public list<Sales_Doc_Detail__c> getproduct(){ 
                    head =   [select Product_Name__c, Qty__c, Unit_Price__c,Extended_Price__c,
                                          Product__r.name from Sales_Doc_Detail__c where Sales_Document__c = :id];
            
            for(Sales_Doc_Detail__c y:head){
                if(y.Product__r.name.startsWith('JDT')){
                   // y.Qty__c = 0;
                    y.Unit_Price__c = y.Extended_Price__c; 
                }
            }return head; 
        }
        
    public list<Sales_Document__c> gethead(){ 
                  doc= [select Doc_Date__c, Sales_Rep__c,  name, customer__c, Line_Total__c
                         from Sales_Document__c where id = :id limit 1];
        
        return doc; 
                         }
}