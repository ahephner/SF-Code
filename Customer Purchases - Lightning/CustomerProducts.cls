//may need to change file type to .apxc
public with sharing class CustomerProducts {
    
    @AuraEnabled
    public static List<Sales_Doc_Detail__c> getProducts(List<String> custnum){
        List<Sales_Doc_Detail__c> productList = [Select doc_date__c,  
                                                 Product_Name__c, Qty__c, Extended_Price__c
                                                 From Sales_Doc_Detail__c
                                                 where Customer__c in :custnum  and
                                                 doc_date__c >= 2018-09-01 and doc_date__c <= 2018-10-01]; 
        return productList; 
    } 
}
