trigger updateProducts2 on Product__c (before insert, before update) {
    
     
    List<Product2> p = [select name, id, Average_Cost__c, 
                       Productcode, Description, size__c  from product2
                       where From_ATS_Product__c = True]; 
    
    system.debug('product2 list ------> '+ p);
    //list to update or insert new entry
    List<Product2> newProdList = new List<Product2>(); 
    List<Product2> updateList = new List<Product2>();
    
    for(Product__c prods: Trigger.new){
        for(product2 pt: p){
            if(prods.Name == pt.ProductCode && prods.JDT_Product__c == True){
                pt.Description = prods.Description__c;
                pt.Average_Cost__c = prods.Average_Cost__c;
                pt.Name = prods.Product_Name__c;
                pt.IsActive = prods.Active__c;
                pt.size__c = prods.size__c; 
                //prods.In_JDT_Service_Book__c = True;
                updateList.add(pt); 
            } else if(prods.JDT_Product__c == True && prods.In_JDT_Service_Book__c == False){
                Product2 npt = new Product2();
                npt.Description = prods.Description__c;
                npt.Average_Cost__c = prods.Average_Cost__c;
                npt.Name = prods.Product_Name__c;
                npt.ProductCode = prods.Name;
                npt.IsActive = prods.Active__c; 
                npt.Size__c = prods.Size__c; 
                npt.From_ATS_Product__c = True;
                prods.In_JDT_Service_Book__c = True; 
                //system.debug('new prod ---> '+ npt);
                newProdList.add(npt);
                system.debug('list in loop --> '+newProdList);
            }
        }
        system.debug('newProdList out---> ' +newProdList); 
    }
    
    if(!newProdList.isEmpty() || !updateList.isEmpty()){
                insert newProdList; 
                upsert updateList; 
            }
}