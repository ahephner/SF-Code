public class appProduct {
 @AuraEnabled(Cacheable=true)
   public static list<areaWrapper> getAreas(ID recordId){
       list<areaWrapper> aw = new list<areaWrapper>();
       for(area__c x:[select id, name from area__c where program__c = :recordId]){
           aw.add(new areaWrapper(x.name, x.id));
       }
       system.debug(aw);
       return aw; 
   }
    
  @AuraEnabled(Cacheable=true)
    public static Product__c[] searchProduct(string searchKey, string cat){
        searchKey = searchKey + '%'; 
        list<product__c> searchResult = new list<product__c>();
        if(cat =='' || cat=='ALL'){
                searchResult = [select name, product_name__c, Subcategory__c from product__c where name like :searchKey or product_name__c like :searchKey ]; 
				system.debug('top select ' +searchResult);                
        }else{
            searchResult = [select name, product_name__c, Subcategory__c from product__c 
                            where subcategory__c = :cat and (name like :searchKey or product_name__c like :searchKey) ]; 
        				system.debug('bottom select ' +searchResult);
        } return searchResult; 
    } 

}