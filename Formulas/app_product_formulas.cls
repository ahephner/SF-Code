//WORK FLOW RULE
//THIS IS THE SET K AMOUNT ON NPK FOR APP PRODUCTS
BLANKVALUE(
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/M'), 
    ((Product__r.X1_Gallon_Weight__c * (Product__r.K__c/1) / 128)) * RATE2__c, 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/Acre'),
    ((Product__r.X1_Gallon_Weight__c * (Product__r.K__c/1) / 128)) * (RATE2__c / 43.56),
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/M'),    
    (Product__r.K__c * RATE2__c), 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry')&& ISPICKVAL( Unit_Area__c , 'LB/Acre'),
     ((Product__r.K__c * RATE2__c) / 43.56), 1)))),0)
//SET N AMOUNT ON NPK FOR APP PRODUCTS
BLANKVALUE(
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/M'), 
    ((Product__r.X1_Gallon_Weight__c * (Product__r.N__c/1) / 128)) * RATE2__c, 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/Acre'),
    ((Product__r.X1_Gallon_Weight__c * (Product__r.N__c/1) / 128)) * (RATE2__c / 43.56),
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/M'),    
    (Product__r.N__c * RATE2__c), 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry')&& ISPICKVAL( Unit_Area__c , 'LB/Acre'),
     ((Product__r.N__c * RATE2__c) / 43.56), 1)))),0)
//SET P AMOUNT ON NPK FOR APP PRODUCTS
BLANKVALUE(
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/M'), 
    ((Product__r.X1_Gallon_Weight__c * (Product__r.P__c/1) / 128)) * RATE2__c, 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/Acre'),
    ((Product__r.X1_Gallon_Weight__c * (Product__r.P__c/1) / 128)) * (RATE2__c / 43.56),
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/M'),    
    (Product__r.P__c * RATE2__c), 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry')&& ISPICKVAL( Unit_Area__c , 'LB/Acre'),
     ((Product__r.P__c * RATE2__c) / 43.56), 1)))),0)     