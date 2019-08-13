public class appProduct {
    //get areas that are already defined; 
 @AuraEnabled(Cacheable=true)
   public static list<areaWrapper> getAreas(ID recordId){
       list<areaWrapper> aw = new list<areaWrapper>();
       for(area__c x:[select id, name from area__c where program__c = :recordId]){
           aw.add(new areaWrapper(x.name, x.id));
       }
       //system.debug(aw);
       return aw; 
   }
//need to make it that if the searchKey is blank nothing happens
//probally better in js    
  @AuraEnabled(Cacheable=true)
    public static Product__c[] searchProduct(string searchKey, string cat){
        searchKey = '%' + searchKey + '%'; 
        system.debug('cat '+ cat); 
        list<product__c> searchResult = new list<product__c>();
        if (cat != null && searchKey == '%%'){
            return null; 
        }
         else if( cat=='ALL'){
                searchResult = [select id, name, product_name__c, Subcategory__c from product__c where Include_in_Programs__c =True and
                                (name like :searchKey or product_name__c like :searchKey) limit 10 ]; 
				//system.debug('top select ' +searchResult);                
        }else{
            searchResult = [select id, name, product_name__c, Subcategory__c from product__c 
                            where subcategory__c = :cat and (name like :searchKey or product_name__c like :searchKey) and Include_in_Programs__c =True limit 10]; 
        				//system.debug('bottom select ' +searchResult);
        } return searchResult; 
    } 
    
    @AuraEnabled(Cacheable=true)
    public static list<Application__c> getApps(ID recordId){
      
        list<application__c> apps = [Select Name, Id, Date__c, Area_Name__c from Application__c where Program_ID__c =: recordId];
        
        return apps;
            
    }
    @AuraEnabled
    public static List<Application_Product__c> appProducts(string app){
        List<Application_Product__c> prods = [select product__c, Product_Name__c,Application__c, Application__r.Name,
                                              Application__r.Date__c, OZ_M__c from application_product__c where application__c =: app];
        system.debug(prods);
        return prods; 
    }
}