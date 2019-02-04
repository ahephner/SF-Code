@isTest
private class Test_ATSProduct_to_Product2_Trigger {
    @isTest static void TestMovingProducts(){
        product__c notinjdt = new product__c(name='123', Product_Name__c = 'not in',In_JDT_Service_Book__c= false,  JDT_Product__c = false,
                                            description__c ='description', average_cost__c = 1, active__c = True);
        insert notinjdt;
        product__c injdt = new product__c(name='456', Product_Name__c = 'in',In_JDT_Service_Book__c= true,  JDT_Product__c = true,
                                            description__c ='hello', average_cost__c = 1, active__c = True);
        insert injdt; 
        list<product__c> atp = [select name, Description__c, jdt_product__c, average_cost__c, 
                               product_name__c, active__c, In_JDT_Service_Book__c from product__c]; 
        product2 npt = new product2(name='new', productcode = '789', From_ATS_Product__c = false );
        product2 pt = new product2(name='in', From_ATS_Product__c= true );
        
        test.startTest();
        database.insert(pt); 
        insert npt;
        product2 testnpt =[select name, description, productcode from product2 where id in :pt];
        
        list<product2> inl = new list<product2>();
		list<product2> updateList = new list<product2>();
        
        
        for(product__c prods: atp){
            if(testnpt.ProductCode == prods.Name && prods.JDT_Product__c == true){
                testnpt.Description = injdt.Description__c;
                inl.add(testnpt);
            }
        }
        if(!inl.isEmpty() || !updateList.isEmpty()){
            insert inl;
            upsert updateList;
        }
        system.debug(inl.size());
        test.stopTest();
        system.assertEquals('hello', testnpt.Description);
        
    }
}
