// public with sharing  class docSearch {
 
// 	@AuraEnabled(Cacheable=true)
//     public static list<Sales_Doc_Detail__c> doc(){
//         return [select Doc_Date__c, Qty__c, Extended_Price__c, Product_Name__c from sales_doc_detail__c
//                where doc_date__c >= 'dateOne' and doc_date__c <= 'dateTwo' and and Sales_Document__r.Customer__c = '123')];//:id];]; 
//     }
// }
//**********Below is testing getting input from client 
public with sharing  class docSearchController {

	  @AuraEnabled
    public static list<Sales_Doc_Detail__c> docSearch(CustomWrapper wrapper) {
		date dOne = date.valueOf(wrapper.one); 
        date dTwo = date.newInstance(wrapper.two.year(), wrapper.two.month(), wrapper.two.day());    
        list<Sales_Doc_Detail__c> call = [SELECT Doc_Date__c, Extended_Price__c, Product_Name__c, Qty__c, Sales_Document__r.Name 
                                          FROM Sales_Doc_Detail__c where  Customer__c = :wrapper.custNum and doc_date__c >= :dOne and doc_date__c <= :dTwo]; 
        system.debug(call);
        return call;
    }
    
}