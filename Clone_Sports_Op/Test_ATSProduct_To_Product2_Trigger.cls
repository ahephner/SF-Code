@isTest
private class Test_ATSProduct_to_Product2_Trigger {
   static testMethod void testInsertRecords(){
    
       List<Product__c> products = new List<Product__c>(); 
	 List<Product2> prod2 = new List<Product2>(); 

     
        Product__c p1 = new Product__c(name='123', Product_Name__c = 'not in',In_JDT_Service_Book__c= false,  JDT_Product__c = True,
                                            description__c ='description', average_cost__c = 1, active__c = True);
        product__c p2 = new Product__c(name='456', Product_Name__c = 'in',In_JDT_Service_Book__c= false,  JDT_Product__c = true,
                                            description__c ='hello', average_cost__c = 1, active__c = true); 
        products.add(p1);
       
       
        
        product2 a1 = new product2(name='new', productcode = '789', description='', From_ATS_Product__c = false );
        product2 a2 = new product2(name='in', productcode = '456', description = '', From_ATS_Product__c= true );
        
        prod2.add(a1);
        prod2.add(a2);
        insert prod2; 
    system.debug('before test prod2 '+prod2);    
    
    
       Test.startTest();
       list<product2> p = [select name, id, Average_Cost__c, 
                       Productcode, Description, size__c  from product2
                       where From_ATS_Product__c = True];
      insert p2;
       insert p1;
       Test.stopTest();
       
       system.assertEquals(p2.In_JDT_Service_Book__c, false);
       system.assertEquals(p2.Name, a2.ProductCode); 
        
   }
}