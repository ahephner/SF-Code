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

//Calc
BLANKVALUE(
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/M'), 
    (Product__r.X1_Gallon_Weight__c * (Product__r.P__c/1) / 128), Product__r.P__c * LBS_ACRE__c)
,0)

//set the Val fields on app products 
//Totally wrong no idea what this is just takes the Calc field and times by the rate
BLANKVALUE(
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/M'), N_Calc__c* Rate2__c,
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/Acre'),( N_Calc__c * Rate2__c )/ 43.56,
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/M'), N_Calc__c * Rate2__c),
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/Acre'),(N_Calc__c * Rate2__c)/43.56,0))))
,0)

BLANKVALUE(
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/M'), 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid') && ISPICKVAL( Unit_Area__c , 'OZ/Acre'), 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/M'), 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/Acre'), 
,0)

BLANKVALUE(
IF(ISPICKVAL(Product__r.Product_Type__c, 'Liquid'), 
    (Product__r.X1_Gallon_Weight__c * (Product__r.P__c/1) / 128), 
IF(ISPICKVAL(Product__r.Product_Type__c, 'Dry') && ISPICKVAL( Unit_Area__c , 'LB/Acre'),
    Product__r.P__c * RATE2__c
    1)
,0)


//Total Used on application product
BLANKVALUE(
IF(ISPICKVAL(Unit_Area__c , 'OZ/M'), Rate2__c * Area_Square_Feet_M__c ,
IF(ISPICKVAL(Unit_Area__c, 'OZ/Acre'), Rate2__c * (Area_Square_Feet_M__c/43.56),
IF(ISPICKVAL(Unit_Area__c, 'LB/M'), Rate2__c * Area_Square_Feet_M__c,
IF(ISPICKVAL(Unit_Area__c, 'LB/Acre'),Rate2__c *(Area_Square_Feet_M__c/43.56),
1)))),0)