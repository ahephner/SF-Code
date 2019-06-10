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
    public static String docSearch(CustomWrapper wrapper) {
        // Using System.debug() isn't good practice for production applications.
        // It's used here to showcase how the received data looks like in Apex.
        System.debug(wrapper);
        // The values are based on the data that is defined in the
        // apexImperativeMethodWithComplexParams Lightning web component.
        String call = 'You entered "' + wrapper.one + '" and "' 
                          + wrapper.two + '"  product string '
                          + wrapper.prodName + ' checkbox =' + wrapper.check; 
        return call;
    }
    
}