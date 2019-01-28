trigger updateProducts2 on Product__c (before insert, before update) {
    
    Product2 npt = new Product2(); 
    List<Product2> p =[select name, id, ATS_Product_ID__c, 
                  Average_Cost__c, ProductCode,Description
                  from product2 where ATS_Product_ID__c != Null]; 
   system.debug('list Product2 ==>> ' + p);
    for(Product__c prods: Trigger.new){
        for(product2 pt: p){
            //GP does not allow product code to be changed once set. So we can treat it as if it is an ID. 
            if(prods.Name == pt.ProductCode && prods.JDT_Product__c == True){
                pt.Description = prods.Description__c; 
                pt.Average_Cost__c = prods.Average_Cost__c;
                pt.Name = prods.Product_Name__c;
                pt.productcode = prods.Name; 
                prods.In_JDT_Price_Book1__c = True; 
                upsert pt; 
            } else if(prods.JDT_Product__c == True && prods.In_JDT_Price_Book1__c == False ){
                npt.Description = prods.Description__c; 
                npt.Average_Cost__c = prods.Average_Cost__c;
                npt.Name = prods.Product_Name__c;
                npt.productcode = prods.Name; 
                npt.from_ats_product__c = True; 
                prods.In_JDT_Price_Book1__c = True; 
                //maybe do a formula field on the object vs. upsert 
                  
                system.debug(npt + ' new prod');
            }
           
        }
        
    }
            if(npt.name != null){
                insert npt; 
            }
}