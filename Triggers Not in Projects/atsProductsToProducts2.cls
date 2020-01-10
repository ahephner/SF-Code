trigger atsProductsToProduct2 on Product__c (before insert, before update) {
	List<String> prodCode = new List<String>();
    List<Product2> newProdList = new List<Product2>();
    List<Product2> updateList = new List<Product2>();
    
    for(Product__c temp: trigger.new){
        if(temp.In_JDT_Service_Book__c == True){
        	prodCode.add(temp.Name);
        }else if (temp.JDT_Product__c == True && temp.In_JDT_Service_Book__c == False){
         	Product2 npt = new Product2();
            npt.Description = temp.Description__c;
            npt.Average_Cost__c = temp.Average_Cost__c;
            npt.Name = temp.Product_Name__c;
            npt.ProductCode = temp.Name;
            npt.IsActive = temp.Active__c; 
            npt.Size__c = temp.Size__c;
            newProdList.add(npt); 
        }       
    }
    
    List<Product2> spProd = [select name, id, Average_Cost__c, 
                      		 Productcode, Description, size__c, product_category__c  from product2
                       		 where ProductCode in :prodCode]; 
    if(spProd.size()> 1){
        for(Product__c prods: Trigger.new){
            for(Product2 pt : spProd){
               		pt.Description = prods.Description__c;
                	pt.Average_Cost__c = prods.Average_Cost__c;
                	pt.Name = prods.Product_Name__c;
                    pt.IsActive = prods.Active__c;
                    pt.size__c = prods.size__c; 
                    //prods.In_JDT_Service_Book__c = True;
                    updateList.add(pt); 
            }
        }
   }	
      if(!newProdList.isEmpty() || !updateList.isEmpty()){
                insert newProdList; 
                upsert updateList; 
            }    
}