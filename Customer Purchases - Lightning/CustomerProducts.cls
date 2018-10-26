public with sharing class CustomerProducts {
    
    @AuraEnabled
    public static List<Sales_Doc_Detail__c> getProducts(List<String> custnum){
        //String customer =  '%' + custnum + '%';
        List<Sales_Doc_Detail__c> returnList = new List<Sales_Doc_Detail__c>(); 
        List<Sales_Doc_Detail__c> productList = [Select doc_date__c,  
                                                 Product_Name__c, Qty__c, Extended_Price__c
                                                 From Sales_Doc_Detail__c
                                                 where Customer__c LIKE: custnum and
                                                 doc_date__c >= 2017-10-01 and doc_date__c <= 2018-09-30 LIMIT 200]; 
        for(Sales_Doc_Detail__c a : productList){
            returnList.add(a);
        }
        return returnList;
    } 

    @AuraEnabled
    public static List<Sales_Doc_Detail__c> twoYears(List<String> custnum){
        //String customer =  '%' + custnum + '%';
        List<Sales_Doc_Detail__c> twoYears = new List<Sales_Doc_Detail__c>(); 
        List<Sales_Doc_Detail__c> secondList = [Select doc_date__c,  
                                                 Product_Name__c, Qty__c, Extended_Price__c
                                                 From Sales_Doc_Detail__c
                                                 where Customer__c LIKE: custnum and
                                                 doc_date__c >= 2016-10-01 and doc_date__c <= 2017-09-30 LIMIT 200]; 
        for(Sales_Doc_Detail__c b : secondList){
            twoYears.add(b);
        }
        return twoYears;
    } 
}
