public class programPDF {
    @AuraEnabled()
    public static list<application_product__c> allProds(string id){
         list<application_product__c> prods = [select id, product_name__c,Units_Required__c,
                                      Total_Price__c from application_product__c where program_id__c = :id]; 
        system.debug('prods => ' + prods);
        return prods; 
    }
}