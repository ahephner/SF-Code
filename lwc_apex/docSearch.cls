public with sharing  class docSearch {
 
	@AuraEnabled(Cacheable=true)
    public static list<Sales_Doc_Detail__c> doc(){
        return [select Doc_Date__c, Qty__c, Extended_Price__c, Product_Name__c from sales_doc_detail__c
               where doc_date__c >= 'dateOne' and doc_date__c <= 'dateTwo' and Customer__c IN (Select AccountNumber from Account where id = '123')];//:id];]; 
    }
}